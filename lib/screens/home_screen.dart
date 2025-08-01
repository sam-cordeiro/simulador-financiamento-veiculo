import 'package:flutter/material.dart';
import '../models/veiculo_models.dart';
import 'vehicle_detail_screen.dart';

/// Tela principal que exibe a lista de veículos disponíveis
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Lista de veículos simulados para demonstração
  /// Utiliza polimorfismo - diferentes tipos de veículos na mesma lista
  List<VeiculoWidget> _getVeiculos(BuildContext context) {
    return [
      // Carros
      CarroWidget(
        nome: 'Honda Civic',
        preco: 85000.00,
        descricao: 'Sedan executivo com excelente custo-benefício',
        imagemUrl: 'images/civicao.jpg',
        combustivel: 'Flex',
        numeroPortas: 4,
        transmissao: 'CVT',
        categoria: 'Sedan',
        onTap: () => _navigateToDetails(context, 'Honda Civic', 85000.00, 'images/civicao.jpg', {
          'Combustível': 'Flex',
          'Número de Portas': '4',
          'Transmissão': 'CVT',
          'Categoria': 'Sedan',
        }),
      ),
      CarroWidget(
        nome: 'Toyota Corolla Cross',
        preco: 95000.00,
        descricao: 'SUV compacto ideal para família',
        imagemUrl: 'images/corollacross.jpg',
        combustivel: 'Híbrido',
        numeroPortas: 5,
        transmissao: 'CVT',
        categoria: 'SUV',
        onTap: () => _navigateToDetails(context, 'Toyota Corolla Cross', 95000.00, 'images/corollacross.jpg', {
          'Combustível': 'Híbrido',
          'Número de Portas': '5',
          'Transmissão': 'CVT',
          'Categoria': 'SUV',
        }),
      ),
      CarroWidget(
        nome: 'Volkswagen Gol',
        preco: 45000.00,
        descricao: 'Hatchback econômico e confiável',
        imagemUrl: 'images/golzao.jpg',
        combustivel: 'Flex',
        numeroPortas: 4,
        transmissao: 'Manual',
        categoria: 'Hatch',
        onTap: () => _navigateToDetails(context, 'Volkswagen Gol', 45000.00, 'images/golzao.jpg', {
          'Combustível': 'Flex',
          'Número de Portas': '4',
          'Transmissão': 'Manual',
          'Categoria': 'Hatch',
        }),
      ),

      // Motos
      MotoWidget(
        nome: 'Honda CB 600F',
        preco: 35000.00,
        descricao: 'Moto esportiva de alta performance',
        imagemUrl: 'images/hornet.jpg', // <-- Imagem correta
        cilindradas: 600,
        tipoFreio: 'Disco',
        temABS: true,
        estilo: 'Esportiva',
        onTap: () => _navigateToDetails(context, 'Honda CB 600F',  35000.00, 'images/hornet.jpg',{
            'Cilindradas': '600cc',
            'Tipo de Freio': 'Disco',
            'ABS': 'Sim',
            'Estilo': 'Esportiva',
          },
        ),
      ),
      MotoWidget(
        nome: 'Yamaha PCX 150',
        preco: 12000.00,
        descricao: 'Scooter urbana econômica e prática',
        imagemUrl: 'images/pcx.jpg',
        cilindradas: 150,
        tipoFreio: 'Disco/Tambor',
        temABS: false,
        estilo: 'Scooter',
        onTap: () => _navigateToDetails(context, 'Yamaha PCX 150', 12000.00, 'images/pcx.jpg', {
          'Cilindradas': '150cc',
          'Tipo de Freio': 'Disco/Tambor',
          'ABS': 'Não',
          'Estilo': 'Scooter',
        }),
      ),
      MotoWidget(
        nome: 'BMW GS 1250',
        preco: 75000.00,
        descricao: 'Adventure para longas viagens',
        imagemUrl: 'images/gs1250.jpg',
        cilindradas: 1250,
        tipoFreio: 'Disco',
        temABS: true,
        estilo: 'Trail',
        onTap: () => _navigateToDetails(context, 'BMW GS 1250', 75000.00, 'images/gs1250.jpg', {
          'Cilindradas': '1250cc',
          'Tipo de Freio': 'Disco',
          'ABS': 'Sim',
          'Estilo': 'Trail',
        }),
      ),

      // Caminhões
      CaminhaoWidget(
        nome: 'Ford Cargo 816',
        preco: 180000.00,
        descricao: 'Caminhão urbano para entregas',
        imagemUrl: 'images/caminhaum.jpg',
        capacidadeCarga: 3.5,
        tipoCarroceria: 'Baú',
        numeroEixos: 2,
        categoria: 'Truck',
        onTap: () => _navigateToDetails(context, 'Ford Cargo 816', 180000.00, 'images/caminhaum.jpg', {
          'Capacidade de Carga': '3.5t',
          'Tipo de Carroceria': 'Baú',
          'Número de Eixos': '2',
          'Categoria': 'Truck',
        }),
      ),
      CaminhaoWidget(
        nome: 'Mercedes Sprinter',
        preco: 220000.00,
        descricao: 'Van executiva para transporte',
        imagemUrl: 'images/sprinter.jpg',
        capacidadeCarga: 1.5,
        tipoCarroceria: 'Furgão',
        numeroEixos: 2,
        categoria: 'Van',
        onTap: () => _navigateToDetails(context, 'Mercedes Sprinter', 220000.00, 'images/sprinter.jpg', {
          'Capacidade de Carga': '1.5t',
          'Tipo de Carroceria': 'Furgão',
          'Número de Eixos': '2',
          'Categoria': 'Van',
        }),
      ),
    ];
  }

  /// Navega para a tela de detalhes do veículo
  void _navigateToDetails(
    BuildContext context,
    String nome,
    double preco,
    String imagemUrl,
    Map<String, dynamic> propriedades,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleDetailScreen(
          nome: nome,
          preco: preco,
          imagemUrl: imagemUrl,
          propriedades: propriedades,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final veiculos = _getVeiculos(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simulador de Financiamento',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Veículos Disponíveis',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selecione um veículo para simular o financiamento',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: veiculos.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: veiculos[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
