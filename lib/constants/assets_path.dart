/// Centralização de todos os assets usados no aplicativo

const _assetPath = 'assets/images';

class ImagesApp {
  static const logo = '$_assetPath/logo.png';
  static const despesas = '$_assetPath/despesas.png';
  static const receitas = '$_assetPath/receitas.png';
  static const cartaoDeCredito = '$_assetPath/cartao_de_credito.png';

  static const casaIcon = '$_assetPath/casa_icon.png';
  static const combustivelIcon = '$_assetPath/combustivel_icon.png';
  static const comprasIcon = '$_assetPath/compras_icon.png';
  static const contaDeAguaIcon = '$_assetPath/conta_de_agua_icon.png';
  static const contaDeLuzIcon = '$_assetPath/conta_de_luz_icon.png';
  static const educacaoIcon = '$_assetPath/educacao_icon.png';
  static const internetFixaIcon = '$_assetPath/internet_fixa_icon.png';
  static const internetMovelIcon = '$_assetPath/internet_movel_icon.png';
  static const lazerIcon = '$_assetPath/lazer_icon.png';
  static const oficinaIcon = '$_assetPath/oficina_icon.png';
  static const padariaIcon = '$_assetPath/padaria_icon.png';

  /// Lista com todos os icons disponiveis na aplicação que são do tipo Image
  static List<String> getAllIcons() {
    return [
      casaIcon,
      combustivelIcon,
      comprasIcon,
      contaDeAguaIcon,
      contaDeLuzIcon,
      educacaoIcon,
      internetFixaIcon,
      internetMovelIcon,
      lazerIcon,
      oficinaIcon,
      padariaIcon
    ];
  }
}
