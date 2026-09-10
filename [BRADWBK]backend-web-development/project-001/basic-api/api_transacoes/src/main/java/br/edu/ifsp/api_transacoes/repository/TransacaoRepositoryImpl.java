package br.edu.ifsp.api_transacoes.repository;

import br.edu.ifsp.api_transacoes.model.Transacao;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@Repository
public class TransacaoRepositoryImpl implements TransacaoRepository {

    private final List<Transacao> transacoes = new ArrayList<>();

    private final AtomicLong idGenerator = new AtomicLong(1);

    @Override
    public Transacao save(Transacao transacao) {

        if (transacao.getId() == null) {

            transacao.setId(idGenerator.getAndIncrement());

            transacoes.add(transacao);

        } else {

            delete(transacao.getId());

            transacoes.add(transacao);
        }

        return transacao;
    }

    @Override
    public Transacao findById(Long id) {

        return transacoes.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Transacao> findAll() {

        return new ArrayList<>(transacoes);
    }

    @Override
    public boolean delete(Long id) {

        Transacao transacao = findById(id);

        if (transacao != null) {
            return transacoes.remove(transacao);
        }

        return false;
    }
}