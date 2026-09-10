package ex1;

public class DadosCompra {
   private boolean ehIndustrializado;
   private boolean ehMunicipal;
   private boolean estaDentroEstado;

   public boolean GetEhIndustrializado() {
      return this.ehIndustrializado;
   }

   public void setEhIndustrializado(boolean ehIndustrializado) {
      this.ehIndustrializado = ehIndustrializado;
   }

   public boolean GetEhMunicipal() {
      return this.ehMunicipal;
   }

   public void setEhMunicipal(boolean ehMunicipal) {
      this.ehMunicipal = ehMunicipal;
   }

   public boolean GetEstaDentroEstado() {
      return this.estaDentroEstado;
   }

   public void setEstaDentroEstado(boolean estaDentroEstado) {
      this.estaDentroEstado = estaDentroEstado;
   }
}
