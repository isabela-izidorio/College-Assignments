package br.edu.ifsp.api_transacoes.repository;

import br.edu.ifsp.api_transacoes.model.Transacao;

import java.util.List;

public interface TransacaoRepository {

    Transacao save(Transacao transacao);

    Transacao findById(Long id);

    List<Transacao> findAll();

    boolean delete(Long id);
}