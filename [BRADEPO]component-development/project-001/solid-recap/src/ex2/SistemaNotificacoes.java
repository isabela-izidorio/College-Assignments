package ex2;

class SistemaNotificacoes {
   private ITipoServicoNotificacao _servicoNotificacao;

   public SistemaNotificacoes(ITipoServicoNotificacao servicoRecebido) {
      this._servicoNotificacao = servicoRecebido;
   }

   public void notificarCliente(String mensagem, String tipo) {
      this._servicoNotificacao.EnviarNotificacao();
   }
}