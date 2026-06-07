enum ChecklistAnswerType {
  yesNo('yes_no'),
  text('text'),
  number('number'),
  singleSelect('single_select'),
  multiSelect('multi_select'),
  photoRequired('photo_required'),
  unknown('unknown');

  const ChecklistAnswerType(this.value);

  final String value;

  static ChecklistAnswerType parse(String value) {
    for (final type in ChecklistAnswerType.values) {
      if (type.value == value) {
        return type;
      }
    }

    return ChecklistAnswerType.unknown;
  }
}
