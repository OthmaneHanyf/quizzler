class Question {
  late String _question;
  late bool _answer;

  Question({required String question, required bool answer}) {
    this._question = question;
    this._answer = answer;
  }

  String getQuestion() => _question;
  bool getAnswer() => _answer;
}
