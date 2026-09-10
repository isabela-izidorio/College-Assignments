package br.edu.ifsp.api_transacoes.service;

import br.edu.ifsp.api_transacoes.model.Transacao;

import java.util.List;

public interface TransacaoService {

    Transacao cadastrar(Transacao transacao);

    Transacao buscarPorId(Long id);

    List<Transacao> listarTodas();

    void atualizar(Long id, Transacao transacao);

    boolean remover(Long id);
}