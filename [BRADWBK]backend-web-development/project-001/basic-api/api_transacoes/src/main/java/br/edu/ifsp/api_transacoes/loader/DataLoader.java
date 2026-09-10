package br.edu.ifsp.api_transacoes.loader;

import br.edu.ifsp.api_transacoes.model.Transacao;
import br.edu.ifsp.api_transacoes.service.TransacaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private TransacaoService service;

    @Override
    public void run(String... args) throws Exception {

        System.out.println(
                "========== INICIALIZANDO CARGA DE DADOS DE TESTE =========="
        );

        service.cadastrar(new Transacao(
                null,
                "Saldo Inicial - Transferência Recebida",
                1500.0,
                LocalDateTime.of(2026, 9, 2, 8, 30, 0)
        ));

        service.cadastrar(new Transacao(
                null,
                "Assinatura Mensal Plataforma DevOps",
                89.90,
                LocalDateTime.of(2026, 9, 2, 9, 15, 30)
        ));

        service.cadastrar(new Transacao(
                null,
                "Compra Material de Escritório",
                124.50,
                LocalDateTime.of(2026, 9, 2, 10, 0, 0)
        ));

        System.out.println(
                "Carga concluída com sucesso! 3 transações foram persistidas no ArrayList."
        );

        System.out.println(
                "============================================================="
        );
    }
}