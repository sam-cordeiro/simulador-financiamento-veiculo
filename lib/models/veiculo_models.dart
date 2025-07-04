import 'package:flutter/material.dart';

/// Classe abstrata base para todos os widgets de veículos
/// Implementa herança através de StatelessWidget
abstract class VeiculoWidget extends StatelessWidget {
  // Propriedades obrigatórias definidas na classe abstrata
  final String nome;
  final double preco;
  final String descricao;
  final String imagemUrl;
  final VoidCallback onTap;

  const VeiculoWidget({
    super.key,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagemUrl,
    required this.onTap,
  });

  /// Método abstrato que deve ser implementado pelas classes filhas
  /// para retornar propriedades específicas do tipo de veículo
  Map<String, dynamic> getPropriedadesEspecificas();

  /// Método comum para construir o card básico do veículo
  /// Demonstra reutilização de código através da herança
  @override
  Widget build(BuildContext context) {
    return Card(
      // Propriedade de layout 1: elevation para sombra
      elevation: 4,
      // Propriedade de layout 2: margin para espaçamento externo
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Propriedade de layout 3: shape para bordas arredondadas
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        // Propriedade de layout 4: borderRadius para área clicável
        borderRadius: BorderRadius.circular(12),
        child: Container(
          // Propriedade de layout 5: padding para espaçamento interno
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widget nativo 1: ClipRRect para imagem com bordas arredondadas
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imagemUrl,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                  // Widget nativo 2: Placeholder para erro de carregamento
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.car_rental, size: 40),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Widget nativo 3: Text para título
                    Text(
                      nome,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      descricao,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Widget nativo 4: Icon para indicar navegação
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Classe derivada para Carros
/// Demonstra herança e especialização
class CarroWidget extends VeiculoWidget {
  // Propriedades específicas de carros (requisito: pelo menos 2)
  final String combustivel;
  final int numeroPortas;
  final String transmissao;
  final String categoria;

  const CarroWidget({
    super.key,
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required super.onTap,
    required this.combustivel,
    required this.numeroPortas,
    required this.transmissao,
    required this.categoria,
  });

  @override
  Map<String, dynamic> getPropriedadesEspecificas() {
    return {
      'Combustível': combustivel,
      'Número de Portas': numeroPortas.toString(),
      'Transmissão': transmissao,
      'Categoria': categoria,
    };
  }
}

/// Classe derivada para Motos
/// Demonstra herança e especialização
class MotoWidget extends VeiculoWidget {
  // Propriedades específicas de motos (requisito: pelo menos 2)
  final int cilindradas;
  final String tipoFreio;
  final bool temABS;
  final String estilo;

  const MotoWidget({
    super.key,
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required super.onTap,
    required this.cilindradas,
    required this.tipoFreio,
    required this.temABS,
    required this.estilo,
  });

  @override
  Map<String, dynamic> getPropriedadesEspecificas() {
    return {
      'Cilindradas': '${cilindradas}cc',
      'Tipo de Freio': tipoFreio,
      'ABS': temABS ? 'Sim' : 'Não',
      'Estilo': estilo,
    };
  }
}

/// Classe derivada para Caminhões
/// Demonstra herança e especialização
class CaminhaoWidget extends VeiculoWidget {
  // Propriedades específicas de caminhões (requisito: pelo menos 2)
  final double capacidadeCarga;
  final String tipoCarroceria;
  final int numeroEixos;
  final String categoria;

  const CaminhaoWidget({
    super.key,
    required super.nome,
    required super.preco,
    required super.descricao,
    required super.imagemUrl,
    required super.onTap,
    required this.capacidadeCarga,
    required this.tipoCarroceria,
    required this.numeroEixos,
    required this.categoria,
  });

  @override
  Map<String, dynamic> getPropriedadesEspecificas() {
    return {
      'Capacidade de Carga': '${capacidadeCarga.toStringAsFixed(1)}t',
      'Tipo de Carroceria': tipoCarroceria,
      'Número de Eixos': numeroEixos.toString(),
      'Categoria': categoria,
    };
  }
}
