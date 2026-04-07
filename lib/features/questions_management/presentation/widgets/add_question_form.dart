import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../laws/domain/entities/law_material_entity.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/answer.dart';

class AddQuestionForm extends StatefulWidget {
  final List<LawMaterialEntity> materials;
  final Function(Question) onAddQuestion;
  final Question? initialQuestion;

  const AddQuestionForm({
    super.key,
    required this.materials,
    required this.onAddQuestion,
    this.initialQuestion,
  });

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMaterialId;
  String? _selectedMaterialContent;
  bool _isActive = false;
  final _questionTextController = TextEditingController();
  final List<TextEditingController> _answerControllers =
      List.generate(4, (_) => TextEditingController());
  int _correctAnswerIndex = 0;
  String _difficulty = 'سهل';
  String _type = 'mcq';

  @override
  void initState() {
    super.initState();
    if (widget.initialQuestion != null) {
      _populateForm(widget.initialQuestion!);
    }
  }

  @override
  void didUpdateWidget(AddQuestionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuestion != oldWidget.initialQuestion) {
      if (widget.initialQuestion != null) {
        _populateForm(widget.initialQuestion!);
      } else {
        _resetForm();
      }
    }
  }

  void _populateForm(Question question) {
    _selectedMaterialId = question.materialId;
    final material = widget.materials.any((m) => m.id == question.materialId)
        ? widget.materials.firstWhere((m) => m.id == question.materialId)
        : null;
    _selectedMaterialContent = material?.content;
    _isActive = question.isActive;
    _questionTextController.text = question.questionText;
    _difficulty = question.difficulty == 'easy'
        ? 'سهل'
        : question.difficulty == 'medium'
            ? 'متوسط'
            : 'صعب';
    _type = question.type;

    for (int i = 0; i < question.answers.length && i < 4; i++) {
      _answerControllers[i].text = question.answers[i].text;
      if (question.answers[i].isCorrect) {
        _correctAnswerIndex = i;
      }
    }
  }

  @override
  void dispose() {
    _questionTextController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onMaterialChanged(String? value) {
    setState(() {
      _selectedMaterialId = value;
      _selectedMaterialContent = widget.materials.firstWhere((m) => m.id == value).content;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final answers = <Answer>[];
      for (int i = 0; i < 4; i++) {
        answers.add(
          Answer(
            text: _answerControllers[i].text,
            isCorrect: i == _correctAnswerIndex,
          ),
        );
      }

      final question = Question(
        questionId: widget.initialQuestion?.questionId,
        lawId: widget.initialQuestion?.lawId ?? '',
        materialId: _selectedMaterialId!,
        level: widget.initialQuestion?.level ?? 1,
        questionText: _questionTextController.text,
        answers: answers,
        difficulty: _difficulty == 'سهل'
            ? 'easy'
            : _difficulty == 'متوسط'
                ? 'medium'
                : 'hard',
        type: _type,
        isActive: _isActive,
      );

      widget.onAddQuestion(question);
      _resetForm();
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _questionTextController.clear();
    for (var controller in _answerControllers) {
      controller.clear();
    }
    setState(() {
      _isActive = false;
      _correctAnswerIndex = 0;
      _difficulty = 'سهل';
      _selectedMaterialId = null;
      _selectedMaterialContent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.edit_note, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(widget.initialQuestion == null ? 'إضافة سؤال' : 'تعديل السؤال',
                    style: AppTextStyles.font18BoldBlack),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('إختر المادة', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedMaterialId,
                        decoration: _inputDecoration('إختر المادة'),
                        items: widget.materials.map((m) {
                          return DropdownMenuItem(
                            value: m.id,
                            child: Text('المادة ${m.order}', style: const TextStyle(fontFamily: 'Cairo')),
                          );
                        }).toList(),
                        onChanged: _onMaterialChanged,
                        validator: (value) => value == null ? 'يرجى اختيار المادة' : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('حالة السؤال', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<bool>(
                        value: _isActive,
                        decoration: _inputDecoration('الحالة'),
                        items: const [
                          DropdownMenuItem(value: true, child: Text('نشط', style: TextStyle(fontFamily: 'Cairo'))),
                          DropdownMenuItem(value: false, child: Text('غير نشط', style: TextStyle(fontFamily: 'Cairo'))),
                        ],
                        onChanged: (val) => setState(() => _isActive = val!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('نص السؤال', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _questionTextController,
                        maxLines: 1,
                        decoration: _inputDecoration('اكتب نص السؤال هنا...'),
                        validator: (value) => value == null || value.isEmpty ? 'يرجى كتابة نص السؤال' : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('نص المادة المرتبطة (للقراءة فقط)', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.grey200),
                        ),
                        child: Text(
                          _selectedMaterialContent ?? 'اختر مادة ليظهر نصها هنا...',
                          style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey600, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('نوع السؤال', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _type,
                        decoration: _inputDecoration('اختر النوع'),
                        items: const [
                          DropdownMenuItem(value: 'mcq', child: Text('مقالي', style: TextStyle(fontFamily: 'Cairo'))),
                          DropdownMenuItem(value: 'true_false', child: Text('صح أو خطأ', style: TextStyle(fontFamily: 'Cairo'))),
                          DropdownMenuItem(value: 'fill', child: Text('أكمل', style: TextStyle(fontFamily: 'Cairo'))),
                          DropdownMenuItem(value: 'case', child: Text('قضية', style: TextStyle(fontFamily: 'Cairo'))),
                        ],
                        onChanged: (val) => setState(() => _type = val!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('مستوى الصعوبة', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      Row(
                        children: ['سهل', 'متوسط', 'صعب'].map((diff) {
                          final isSelected = _difficulty == diff;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _difficulty = diff),
                              child: Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? (diff == 'سهل' ? Colors.green.withOpacity(0.1) : diff == 'متوسط' ? Colors.orange.withOpacity(0.1) : Colors.red.withOpacity(0.1)) : AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? (diff == 'سهل' ? Colors.green : diff == 'متوسط' ? Colors.orange : Colors.red) : AppColors.grey200,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    diff,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      color: isSelected ? (diff == 'سهل' ? Colors.green : diff == 'متوسط' ? Colors.orange : Colors.red) : AppColors.grey600,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('الخيارات', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
            const Text('حدد الإجابة الصحيحة', style: TextStyle(fontFamily: 'Cairo', fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                crossAxisSpacing: 24,
                mainAxisSpacing: 12,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final label = ['أ', 'ب', 'ج', 'د'][index];
                return Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: _correctAnswerIndex,
                      onChanged: (val) => setState(() => _correctAnswerIndex = val!),
                      activeColor: Colors.blue,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _answerControllers[index],
                        decoration: _inputDecoration('الخيار $label'),
                        validator: (value) => value == null || value.isEmpty ? 'يرجى كتابة الخيار' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(label, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(widget.initialQuestion == null ? Icons.add : Icons.save,
                    color: AppColors.white),
                label: Text(
                    widget.initialQuestion == null ? 'إضافة سؤال' : 'تحديث السؤال',
                    style: const TextStyle(fontFamily: 'Cairo', color: AppColors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.grey400),
      filled: true,
      fillColor: AppColors.grey50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.grey200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.grey200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
