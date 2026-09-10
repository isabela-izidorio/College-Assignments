package br.edu.ifsp.api_transacoes.controller;

import br.edu.ifsp.api_transacoes.model.Transacao;
import br.edu.ifsp.api_transacoes.service.TransacaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/transacoes")
public class TransacaoController {

    @Autowired
    private TransacaoService service;

    @RequestMapping(method = RequestMethod.GET)
    public List<Transacao> listar() {
        return service.listarTodas();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<Transacao> buscar(@PathVariable Long id) {

        Transacao transacao = service.buscarPorId(id);

        if (transacao != null) {
            return ResponseEntity.ok(transacao);
        }

        return new ResponseEntity<Transacao>(HttpStatus.NOT_FOUND);
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.CREATED)
    public Transacao criar(@RequestBody Transacao transacao) {
        return service.cadastrar(transacao);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Void> atualizar(
            @PathVariable Long id,
            @RequestBody Transacao transacao) {

        try {
            service.atualizar(id, transacao);

            return ResponseEntity.ok().build();

        } catch (IllegalArgumentException e) {

            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<String> deletar(@PathVariable Long id) {

        boolean removido = service.remover(id);

        if (removido) {
            return ResponseEntity.ok(
                    "Remoção da transação com ID "
                            + id
                            + " realizada com sucesso."
            );
        }

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body("Transação com ID " + id + " não localizada.");
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> tratarErrosDeRegraDeNegocio(
            IllegalArgumentException ex) {

        return ResponseEntity
                .badRequest()
                .body(ex.getMessage());
    }
}