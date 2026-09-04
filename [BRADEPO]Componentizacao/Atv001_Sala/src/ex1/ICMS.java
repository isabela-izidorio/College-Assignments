package ex1;

public class ICMS extends Imposto {
   public double CobrarImposto(double valorCompra, DadosCompra dadosCompra) {
      double result = 0.0;
      return !dadosCompra.GetEhIndustrializado() ? result : result;
   }
}
