import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Food'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Transportation'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Shopping'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Entertainment'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Other'),
                ],
              ),
            ),
          ),

          // Expenses List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDateSection('Today', [
                  {
                    'title': 'Migros Market',
                    'category': 'Food',
                    'amount': '-₺125.50',
                    'time': '14:30',
                    'icon': Icons.restaurant,
                    'color': const Color(0xFF1976D2),
                  },
                  {
                    'title': 'Uber',
                    'category': 'Transportation',
                    'amount': '-₺45.00',
                    'time': '12:15',
                    'icon': Icons.directions_car,
                    'color': const Color(0xFF42A5F5),
                  },
                  {
                    'title': 'Starbucks',
                    'category': 'Food',
                    'amount': '-₺85.00',
                    'time': '09:00',
                    'icon': Icons.local_cafe,
                    'color': const Color(0xFF1976D2),
                  },
                ]),
                const SizedBox(height: 24),
                _buildDateSection('Yesterday', [
                  {
                    'title': 'Zara',
                    'category': 'Shopping',
                    'amount': '-₺350.00',
                    'time': '18:45',
                    'icon': Icons.shopping_bag,
                    'color': const Color(0xFF64B5F6),
                  },
                  {
                    'title': 'IETT',
                    'category': 'Transportation',
                    'amount': '-₺25.00',
                    'time': '08:30',
                    'icon': Icons.directions_bus,
                    'color': const Color(0xFF42A5F5),
                  },
                ]),
                const SizedBox(height: 24),
                _buildDateSection('2 Days Ago', [
                  {
                    'title': 'Netflix',
                    'category': 'Entertainment',
                    'amount': '-₺99.90',
                    'time': '15:00',
                    'icon': Icons.movie,
                    'color': const Color(0xFF90CAF9),
                  },
                  {
                    'title': 'A101',
                    'category': 'Food',
                    'amount': '-₺165.75',
                    'time': '13:20',
                    'icon': Icons.shopping_cart,
                    'color': const Color(0xFF1976D2),
                  },
                  {
                    'title': 'Shell',
                    'category': 'Transportation',
                    'amount': '-₺450.00',
                    'time': '10:00',
                    'icon': Icons.local_gas_station,
                    'color': const Color(0xFF42A5F5),
                  },
                ]),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new expense
        },
        backgroundColor: const Color(0xFF1976D2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Expense',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      backgroundColor: Colors.grey[100],
      selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF1976D2) : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? const Color(0xFF1976D2) : Colors.grey[300]!,
      ),
    );
  }

  Widget _buildDateSection(
    String date,
    List<Map<String, dynamic>> transactions,
  ) {
    double total = 0;
    for (var transaction in transactions) {
      final amountStr = (transaction['amount'] as String)
          .replaceAll('-₺', '')
          .replaceAll(',', '.');
      total += double.parse(amountStr);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              '-₺${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...transactions.map((transaction) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (transaction['color'] as Color).withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    transaction['icon'] as IconData,
                    color: transaction['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${transaction['category']} • ${transaction['time']}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction['amount'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF1976D2),
                ),
                title: const Text('Date Range'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.category, color: Color(0xFF1976D2)),
                title: const Text('Category'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Color(0xFF1976D2),
                ),
                title: const Text('Amount Range'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
