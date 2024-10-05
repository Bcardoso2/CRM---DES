import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AtividadesScreen extends StatefulWidget {
  @override
  _AtividadesScreenState createState() => _AtividadesScreenState();
}

class _AtividadesScreenState extends State<AtividadesScreen> {
  late Map<DateTime, List<String>> events;
  late List<String> selectedEvents;
  late DateTime selectedDay;

  String? selectedDeacon;
  TimeOfDay? selectedTime;
  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    events = {};
    selectedEvents = events[selectedDay] ?? [];
    selectedDeacon = 'Diácono Andrey'; // Diácono padrão
    selectedLocation = 'Matriz'; // Local padrão
  }

  void addEvent(String event) {
    if (event.isEmpty || selectedTime == null || selectedDeacon == null || selectedLocation == null) return; // Não adiciona se algum campo estiver vazio
    String eventDetails = '$event - ${selectedTime!.hour}:${selectedTime!.minute} - $selectedDeacon - $selectedLocation';
    if (events[selectedDay] != null) {
      events[selectedDay]?.add(eventDetails);
    } else {
      events[selectedDay] = [eventDetails];
    }
    setState(() {
      selectedEvents = events[selectedDay]!;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Atividades')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: selectedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                selectedEvents = events[selectedDay] ?? [];
              });
            },
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedEvents[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController eventController = TextEditingController();
                    return AlertDialog(
                      title: Text('Adicionar Evento'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: eventController,
                            decoration: InputDecoration(labelText: 'Evento'),
                          ),
                          SizedBox(height: 10),
                          DropdownButton<String>(
                            value: selectedDeacon,
                            items: <String>['Diácono Andrey', 'Diácono João']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDeacon = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          DropdownButton<String>(
                            value: selectedLocation,
                            items: <String>[
                              'Matriz',
                              'Comunidade Belém',
                              'Comunidade São José',
                              'Comunidade Externa'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocation = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () => _selectTime(context),
                            child: Text(selectedTime == null
                                ? 'Selecionar Horário'
                                : 'Horário: ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            addEvent(eventController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('Adicionar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Adicionar Evento'),
            ),
          ),
        ],
      ),
    );
  }
}
