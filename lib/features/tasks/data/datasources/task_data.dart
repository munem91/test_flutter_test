import '../../domain/models/task.dart';

final sampleTasks = [
  const Task(
    id: '1',
    question:
        'A plane leaves point A at 08:00 and flies 600 km at 300 km/h. What time does it arrive at point B?',
    options: ['10:00', '09:30', '10:30', '09:00'],
    correctAnswer: '10:00',
    type: TaskType.timeCalculation,
    level: 1,
    explanation:
        'Time = Distance/Speed = 600/300 = 2 hours. 08:00 + 2 hours = 10:00',
  ),
  const Task(
    id: '2',
    question:
        'A plane needs to fly at a heading of 45 degrees. What is the angle between the plane\'s current heading of 270 degrees and the required heading?',
    options: ['135°', '225°', '45°', '315°'],
    correctAnswer: '135°',
    type: TaskType.directionAngle,
    level: 1,
    explanation:
        'The angle between 270° and 45° is 135° (270° - 45° = 225°, but we take the smaller angle)',
  ),
  const Task(
    id: '3',
    question:
        'A plane consumes 2000 liters of fuel per hour. How much fuel will it need for a 3.5-hour flight?',
    options: ['7000 L', '6000 L', '8000 L', '7500 L'],
    correctAnswer: '7000 L',
    type: TaskType.fuelConsumption,
    level: 1,
    explanation:
        'Fuel needed = Consumption rate × Time = 2000 × 3.5 = 7000 liters',
  ),
  const Task(
    id: '4',
    question:
        'A cargo plane can carry 5000 kg. Current cargo is 3200 kg. How much additional cargo can be loaded?',
    options: ['1800 kg', '1700 kg', '1900 kg', '2000 kg'],
    correctAnswer: '1800 kg',
    type: TaskType.cargoBalance,
    level: 1,
    explanation:
        'Available capacity = Maximum load - Current load = 5000 - 3200 = 1800 kg',
  ),
];
