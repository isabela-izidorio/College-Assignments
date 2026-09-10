package br.edu.ifsp.api_transacoes.service;

import br.edu.ifsp.api_transacoes.model.Transacao;
import br.edu.ifsp.api_transacoes.repository.TransacaoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransacaoServiceImpl implements TransacaoService {

    @Autowired
    private TransacaoRepository repository;

    @Override
    public Transacao cadastrar(Transacao transacao) {

        validarTransacao(transacao);

        return repository.save(transacao);
    }

    @Override
    public Transacao buscarPorId(Long id) {

        return repository.findById(id);
    }

    @Override
    public List<Transacao> listarTodas() {

        return repository.findAll();
    }

    @Override
    public void atualizar(Long id, Transacao transacao) {

        Transacao existente = repository.findById(id);

        if (existente == null) {
            throw new IllegalArgumentException(
                    "Não é possível atualizar: transação não encontrada."
            );
        }

        validarTransacao(transacao);

        transacao.setId(id);

        repository.save(transacao);
    }

    @Override
    public boolean remover(Long id) {

        return repository.delete(id);
    }

    private void validarTransacao(Transacao t) {

        if (t == null) {
            throw new IllegalArgumentException(
                    "A transação não pode ser nula."
            );
        }

        if (t.getDescricao() == null ||
                t.getDescricao().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "A descrição da transação é de preenchimento obrigatório."
            );
        }

        if (t.getValor() == null ||
                t.getValor() <= 0) {

            throw new IllegalArgumentException(
                    "O valor da transação deve ser estritamente maior que zero."
            );
        }

        if (t.getDataHora() == null) {

            throw new IllegalArgumentException(
                    "A data e hora da transação devem ser informadas."
            );
        }
    }
}