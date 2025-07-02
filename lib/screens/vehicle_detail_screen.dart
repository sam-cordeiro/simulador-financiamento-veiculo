import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tela de detalhes do veículo com calculadora de financiamento
class VehicleDetailScreen extends StatefulWidget {
  final String nome;
  final double preco;
  final Map<String, dynamic> propriedades;

  const VehicleDetailScreen({
    super.key,
    required this.nome,
    required this.preco,
    required this.propriedades,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  // Controladores para os campos de entrada
  final TextEditingController _entradaController = TextEditingController();
  final TextEditingController _prazoController = TextEditingController();
  
  // Variáveis para os cálculos
  double _valorFinanciado = 0.0;
  double _valorParcela = 0.0;
  double _valorTotal = 0.0;
  bool _calculoRealizado = false;

  /// Calcula a simulação de financiamento
  /// Implementa a lógica de negócio conforme especificado
  void _calcularFinanciamento() {
    final entrada = double.tryParse(_entradaController.text.replaceAll(',', '.')) ?? 0.0;
    final prazo = int.tryParse(_prazoController.text) ?? 0;

    if (entrada < 0 || entrada > widget.preco) {
      _showErrorDialog('Valor de entrada inválido. Deve ser entre R\$ 0,00 e R\$ ${widget.preco.toStringAsFixed(2)}');
      return;
    }

    if (prazo <= 0 || prazo > 72) {
      _showErrorDialog('Prazo inválido. Deve ser entre 1 e 72 meses.');
      return;
    }

    setState(() {
      // Fórmula conforme especificado:
      _valorFinanciado = widget.preco - entrada;
      // Simulando juros de 2% ao mês
      _valorParcela = (_valorFinanciado / prazo) * 1.02;
      _valorTotal = (_valorParcela * prazo) + entrada;
      _calculoRealizado = true;
    });
  }

  /// Exibe dialog de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Limpa os campos e resultados
  void _limparCalculos() {
    setState(() {
      _entradaController.clear();
      _prazoController.clear();
      _valorFinanciado = 0.0;
      _valorParcela = 0.0;
      _valorTotal = 0.0;
      _calculoRealizado = false;
    });
  }

  @override
  void dispose() {
    _entradaController.dispose();
    _prazoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card com informações do veículo
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagem do veículo
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '/placeholder.svg?height=200&width=300',
                          height: 200,
                          width: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: 300,
                              color: Colors.grey[300],
                              child: const Icon(Icons.car_rental, size: 80),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nome e preço
                    Text(
                      widget.nome,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${widget.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Propriedades específicas do veículo
                    Text(
                      'Características:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.propriedades.entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            '${entry.key}: ',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(entry.value.toString()),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Calculadora de financiamento
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simulação de Financiamento',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Campo de entrada
                    TextField(
                      controller: _entradaController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Valor de Entrada (R\$)',
                        hintText: '0,00',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Campo de prazo
                    TextField(
                      controller: _prazoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Prazo (meses)',
                        hintText: '12',
                        prefixIcon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Botões
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _calcularFinanciamento,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Calcular',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _limparCalculos,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Limpar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Resultados da simulação
                    if (_calculoRealizado) ...[
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resultado da Simulação:',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow('Valor Financiado:', _valorFinanciado),
                            _buildResultRow('Valor da Parcela:', _valorParcela),
                            _buildResultRow('Valor Total:', _valorTotal),
                            const SizedBox(height: 8),
                            Text(
                              '* Simulação com juros de 2% ao mês',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget helper para construir linhas de resultado
  Widget _buildResultRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
