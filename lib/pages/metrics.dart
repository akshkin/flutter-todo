import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo.provider.dart';
import 'package:todo/theme/colors.dart';

class Metrics extends ConsumerWidget {
  Metrics({super.key});

  final List<TodoProgress> progressData = [
    TodoProgress("1/9/2024", 3),
    TodoProgress("2/9/2024", 2),
    TodoProgress("3/9/2024", 5),
    TodoProgress("4/9/2024", 1),
    TodoProgress("5/9/2024", 4),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    String text = "";

    for (int i = value.toInt(); i < progressData.length; i++) {
      text = progressData[i].date.substring(5);
      break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos =
        todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metrics'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              margin: const EdgeInsets.all(8),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: completedTodos.length.toDouble(),
                      color: const Color.fromARGB(255, 121, 234, 125),
                      title:
                          "${(completedTodos.length * 100 / todos.length).toStringAsFixed(2)}%",
                    ),
                    PieChartSectionData(
                      value: activeTodos.length.toDouble(),
                      color: const Color.fromARGB(255, 95, 193, 225),
                      title:
                          "${(activeTodos.length * 100 / todos.length).toStringAsFixed(2)}%",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    color: ColorPallete.greenDark,
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  ),
                  const Text("Completed"),
                ],
              ),
              Row(
                children: [
                  Container(
                    color: ColorPallete.blueDark,
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  ),
                  const Text("Active"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
          AspectRatio(
            aspectRatio: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: false, reservedSize: 10),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: bottomTitleWidgets,
                        showTitles: true,
                        interval: 1,
                        reservedSize: 20,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: progressData.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(),
                          e.value.completedTodos.toDouble(),
                        );
                      }).toList(),
                    ),
                    // LineChartBarData(
                    //     spots: todos.asMap().entries.map((e) {
                    //   return FlSpot(
                    //       e.key.toDouble(), activeTodos.length.toDouble());
                    // }).toList()),
                  ],
                ),
              ),
            ),
          ),
          const Text("Number of todos completed each day")
        ],
      ),
    );
  }
}

class TodoProgress {
  final String date;
  final int completedTodos;

  TodoProgress(this.date, this.completedTodos);
}
