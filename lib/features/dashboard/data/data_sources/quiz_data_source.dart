import '../models/quiz_model.dart';

abstract class QuizDataSource {
  Future<List<QuizModel>> getAvailableQuizzes();
  Future<List<QuestionModel>> getQuizQuestions(String quizId);
}

class QuizDataSourceImpl implements QuizDataSource {
  @override
  Future<List<QuizModel>> getAvailableQuizzes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      QuizModel(
        id: '1',
        title: 'Indian Constitution',
        description: 'Test your knowledge about the Indian Constitution, fundamental rights, and democratic principles.',
        category: 'Civics',
        totalQuestions: 10,
        timeLimit: 15,
        imageUrl: 'assets/images/constitution.jpg',
      ),
      QuizModel(
        id: '2',
        title: 'Indian History',
        description: 'Explore the rich history of India from ancient times to modern era.',
        category: 'History',
        totalQuestions: 10,
        timeLimit: 15,
        imageUrl: 'assets/images/history.png',
      ),
      QuizModel(
        id: '3',
        title: 'Geography of India',
        description: 'Learn about India\'s diverse geography, climate, and natural resources.',
        category: 'Geography',
        totalQuestions: 10,
        timeLimit: 15,
        imageUrl: 'assets/images/ncert.png',
      ),
      QuizModel(
        id: '4',
        title: 'General Knowledge',
        description: 'Test your general knowledge about current affairs and important facts.',
        category: 'General',
        totalQuestions: 10,
        timeLimit: 15,
        imageUrl: 'assets/images/gcert.jpeg',
      ),
    ];
  }

  @override
  Future<List<QuestionModel>> getQuizQuestions(String quizId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    switch (quizId) {
      case '1': // Indian Constitution
        return [
          QuestionModel(
            id: '1_1',
            questionText: 'When was the Indian Constitution adopted?',
            options: ['26 January 1950', '26 November 1949', '15 August 1947', '26 January 1949'],
            correctAnswerIndex: 1,
            explanation: 'The Indian Constitution was adopted on 26 November 1949 and came into effect on 26 January 1950.',
          ),
          QuestionModel(
            id: '1_2',
            questionText: 'How many fundamental rights are guaranteed by the Indian Constitution?',
            options: ['5', '6', '7', '8'],
            correctAnswerIndex: 1,
            explanation: 'The Indian Constitution guarantees 6 fundamental rights to all citizens.',
          ),
          QuestionModel(
            id: '1_3',
            questionText: 'Who is known as the Father of the Indian Constitution?',
            options: ['Mahatma Gandhi', 'Jawaharlal Nehru', 'Dr. B.R. Ambedkar', 'Sardar Patel'],
            correctAnswerIndex: 2,
            explanation: 'Dr. B.R. Ambedkar is known as the Father of the Indian Constitution.',
          ),
          QuestionModel(
            id: '1_4',
            questionText: 'Which article of the Indian Constitution abolishes untouchability?',
            options: ['Article 15', 'Article 16', 'Article 17', 'Article 18'],
            correctAnswerIndex: 2,
            explanation: 'Article 17 of the Indian Constitution abolishes untouchability.',
          ),
          QuestionModel(
            id: '1_5',
            questionText: 'What is the minimum age to become the President of India?',
            options: ['30 years', '35 years', '40 years', '45 years'],
            correctAnswerIndex: 1,
            explanation: 'The minimum age to become the President of India is 35 years.',
          ),
          QuestionModel(
            id: '1_6',
            questionText: 'Which is the longest written constitution in the world?',
            options: ['US Constitution', 'Indian Constitution', 'British Constitution', 'Canadian Constitution'],
            correctAnswerIndex: 1,
            explanation: 'The Indian Constitution is the longest written constitution in the world.',
          ),
          QuestionModel(
            id: '1_7',
            questionText: 'How many schedules are there in the Indian Constitution?',
            options: ['10', '11', '12', '13'],
            correctAnswerIndex: 2,
            explanation: 'There are 12 schedules in the Indian Constitution.',
          ),
          QuestionModel(
            id: '1_8',
            questionText: 'Which fundamental right is known as the "Right to Constitutional Remedies"?',
            options: ['Right to Equality', 'Right to Freedom', 'Right against Exploitation', 'Right to Constitutional Remedies'],
            correctAnswerIndex: 3,
            explanation: 'Article 32 provides the Right to Constitutional Remedies.',
          ),
          QuestionModel(
            id: '1_9',
            questionText: 'Who appoints the Chief Justice of India?',
            options: ['Prime Minister', 'President', 'Parliament', 'Supreme Court'],
            correctAnswerIndex: 1,
            explanation: 'The President appoints the Chief Justice of India.',
          ),
          QuestionModel(
            id: '1_10',
            questionText: 'What is the term of office of the President of India?',
            options: ['4 years', '5 years', '6 years', '7 years'],
            correctAnswerIndex: 1,
            explanation: 'The President of India holds office for a term of 5 years.',
          ),
        ];
      case '2': // Indian History
        return [
          QuestionModel(
            id: '2_1',
            questionText: 'In which year did India gain independence from British rule?',
            options: ['1945', '1946', '1947', '1948'],
            correctAnswerIndex: 2,
            explanation: 'India gained independence from British rule on 15 August 1947.',
          ),
          QuestionModel(
            id: '2_2',
            questionText: 'Who was the first Prime Minister of India?',
            options: ['Mahatma Gandhi', 'Jawaharlal Nehru', 'Sardar Patel', 'Dr. Rajendra Prasad'],
            correctAnswerIndex: 1,
            explanation: 'Jawaharlal Nehru was the first Prime Minister of India.',
          ),
          QuestionModel(
            id: '2_3',
            questionText: 'Which empire was founded by Chandragupta Maurya?',
            options: ['Gupta Empire', 'Maurya Empire', 'Mughal Empire', 'Maratha Empire'],
            correctAnswerIndex: 1,
            explanation: 'Chandragupta Maurya founded the Maurya Empire.',
          ),
          QuestionModel(
            id: '2_4',
            questionText: 'Who was the first woman Prime Minister of India?',
            options: ['Indira Gandhi', 'Sonia Gandhi', 'Pratibha Patil', 'Sarojini Naidu'],
            correctAnswerIndex: 0,
            explanation: 'Indira Gandhi was the first woman Prime Minister of India.',
          ),
          QuestionModel(
            id: '2_5',
            questionText: 'Which battle marked the beginning of British rule in India?',
            options: ['Battle of Plassey', 'Battle of Buxar', 'Battle of Panipat', 'Battle of Haldighati'],
            correctAnswerIndex: 0,
            explanation: 'The Battle of Plassey (1757) marked the beginning of British rule in India.',
          ),
          QuestionModel(
            id: '2_6',
            questionText: 'Who started the Quit India Movement?',
            options: ['Subhas Chandra Bose', 'Mahatma Gandhi', 'Bhagat Singh', 'Chandrashekhar Azad'],
            correctAnswerIndex: 1,
            explanation: 'Mahatma Gandhi started the Quit India Movement in 1942.',
          ),
          QuestionModel(
            id: '2_7',
            questionText: 'Which was the first civilization in India?',
            options: ['Vedic Civilization', 'Indus Valley Civilization', 'Mauryan Civilization', 'Gupta Civilization'],
            correctAnswerIndex: 1,
            explanation: 'The Indus Valley Civilization was the first civilization in India.',
          ),
          QuestionModel(
            id: '2_8',
            questionText: 'Who was the last Mughal Emperor of India?',
            options: ['Aurangzeb', 'Bahadur Shah Zafar', 'Shah Jahan', 'Akbar'],
            correctAnswerIndex: 1,
            explanation: 'Bahadur Shah Zafar was the last Mughal Emperor of India.',
          ),
          QuestionModel(
            id: '2_9',
            questionText: 'In which year was the Indian National Congress founded?',
            options: ['1885', '1886', '1887', '1888'],
            correctAnswerIndex: 0,
            explanation: 'The Indian National Congress was founded in 1885.',
          ),
          QuestionModel(
            id: '2_10',
            questionText: 'Who is known as the "Iron Man of India"?',
            options: ['Subhas Chandra Bose', 'Sardar Vallabhbhai Patel', 'Bhagat Singh', 'Chandrashekhar Azad'],
            correctAnswerIndex: 1,
            explanation: 'Sardar Vallabhbhai Patel is known as the "Iron Man of India".',
          ),
        ];
      case '3': // Geography
        return [
          QuestionModel(
            id: '3_1',
            questionText: 'What is the capital of India?',
            options: ['Mumbai', 'Kolkata', 'New Delhi', 'Chennai'],
            correctAnswerIndex: 2,
            explanation: 'New Delhi is the capital of India.',
          ),
          QuestionModel(
            id: '3_2',
            questionText: 'Which is the highest peak in India?',
            options: ['Mount Everest', 'K2', 'Kangchenjunga', 'Nanda Devi'],
            correctAnswerIndex: 2,
            explanation: 'Kangchenjunga is the highest peak in India.',
          ),
          QuestionModel(
            id: '3_3',
            questionText: 'Which river is known as the "Ganga of the South"?',
            options: ['Krishna', 'Godavari', 'Cauvery', 'Mahanadi'],
            correctAnswerIndex: 1,
            explanation: 'The Godavari river is known as the "Ganga of the South".',
          ),
          QuestionModel(
            id: '3_4',
            questionText: 'How many states are there in India?',
            options: ['26', '27', '28', '29'],
            correctAnswerIndex: 2,
            explanation: 'There are 28 states in India.',
          ),
          QuestionModel(
            id: '3_5',
            questionText: 'Which is the largest state in India by area?',
            options: ['Maharashtra', 'Madhya Pradesh', 'Rajasthan', 'Uttar Pradesh'],
            correctAnswerIndex: 2,
            explanation: 'Rajasthan is the largest state in India by area.',
          ),
          QuestionModel(
            id: '3_6',
            questionText: 'Which ocean lies to the south of India?',
            options: ['Atlantic Ocean', 'Pacific Ocean', 'Indian Ocean', 'Arctic Ocean'],
            correctAnswerIndex: 2,
            explanation: 'The Indian Ocean lies to the south of India.',
          ),
          QuestionModel(
            id: '3_7',
            questionText: 'What is the national animal of India?',
            options: ['Lion', 'Tiger', 'Elephant', 'Peacock'],
            correctAnswerIndex: 1,
            explanation: 'The Tiger is the national animal of India.',
          ),
          QuestionModel(
            id: '3_8',
            questionText: 'Which is the largest desert in India?',
            options: ['Thar Desert', 'Rann of Kutch', 'Ladakh Desert', 'Cold Desert'],
            correctAnswerIndex: 0,
            explanation: 'The Thar Desert is the largest desert in India.',
          ),
          QuestionModel(
            id: '3_9',
            questionText: 'How many union territories are there in India?',
            options: ['6', '7', '8', '9'],
            correctAnswerIndex: 2,
            explanation: 'There are 8 union territories in India.',
          ),
          QuestionModel(
            id: '3_10',
            questionText: 'Which is the smallest state in India by area?',
            options: ['Goa', 'Sikkim', 'Tripura', 'Mizoram'],
            correctAnswerIndex: 0,
            explanation: 'Goa is the smallest state in India by area.',
          ),
        ];
      case '4': // General Knowledge
        return [
          QuestionModel(
            id: '4_1',
            questionText: 'What is the national flower of India?',
            options: ['Rose', 'Lotus', 'Sunflower', 'Marigold'],
            correctAnswerIndex: 1,
            explanation: 'The Lotus is the national flower of India.',
          ),
          QuestionModel(
            id: '4_2',
            questionText: 'Who wrote the national anthem of India?',
            options: ['Rabindranath Tagore', 'Bankim Chandra Chatterjee', 'Subhas Chandra Bose', 'Mahatma Gandhi'],
            correctAnswerIndex: 0,
            explanation: 'Rabindranath Tagore wrote the national anthem of India.',
          ),
          QuestionModel(
            id: '4_3',
            questionText: 'What is the national bird of India?',
            options: ['Eagle', 'Peacock', 'Sparrow', 'Crow'],
            correctAnswerIndex: 1,
            explanation: 'The Peacock is the national bird of India.',
          ),
          QuestionModel(
            id: '4_4',
            questionText: 'Which is the national tree of India?',
            options: ['Banyan Tree', 'Neem Tree', 'Mango Tree', 'Coconut Tree'],
            correctAnswerIndex: 0,
            explanation: 'The Banyan Tree is the national tree of India.',
          ),
          QuestionModel(
            id: '4_5',
            questionText: 'What is the national fruit of India?',
            options: ['Apple', 'Mango', 'Banana', 'Orange'],
            correctAnswerIndex: 1,
            explanation: 'The Mango is the national fruit of India.',
          ),
          QuestionModel(
            id: '4_6',
            questionText: 'Who is known as the "Father of the Nation"?',
            options: ['Jawaharlal Nehru', 'Mahatma Gandhi', 'Subhas Chandra Bose', 'Sardar Patel'],
            correctAnswerIndex: 1,
            explanation: 'Mahatma Gandhi is known as the "Father of the Nation".',
          ),
          QuestionModel(
            id: '4_7',
            questionText: 'What is the national song of India?',
            options: ['Jana Gana Mana', 'Vande Mataram', 'Sare Jahan Se Achha', 'Saare Jahan Se Achha'],
            correctAnswerIndex: 1,
            explanation: 'Vande Mataram is the national song of India.',
          ),
          QuestionModel(
            id: '4_8',
            questionText: 'Which is the national aquatic animal of India?',
            options: ['Dolphin', 'Whale', 'Shark', 'Turtle'],
            correctAnswerIndex: 0,
            explanation: 'The Dolphin is the national aquatic animal of India.',
          ),
          QuestionModel(
            id: '4_9',
            questionText: 'What is the national reptile of India?',
            options: ['Cobra', 'Python', 'King Cobra', 'Viper'],
            correctAnswerIndex: 2,
            explanation: 'The King Cobra is the national reptile of India.',
          ),
          QuestionModel(
            id: '4_10',
            questionText: 'Which is the national heritage animal of India?',
            options: ['Lion', 'Tiger', 'Elephant', 'Rhinoceros'],
            correctAnswerIndex: 2,
            explanation: 'The Elephant is the national heritage animal of India.',
          ),
        ];
      default:
        return [];
    }
  }
} 