import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../laws/domain/entities/law_entity.dart';
import '../bloc/questions_cubit.dart';
import '../bloc/questions_state.dart';
import '../widgets/law_levels_bar.dart';
import '../widgets/add_question_form.dart';
import '../widgets/questions_list_section.dart';
import '../widgets/save_questions_popup.dart';
import '../widgets/share_questions_popup.dart';

class AddQuestionsPage extends StatefulWidget {
  final LawEntity law;
  final VoidCallback onBack;

  const AddQuestionsPage({super.key, required this.law, required this.onBack});

  @override
  State<AddQuestionsPage> createState() => _AddQuestionsPageState();
}

class _AddQuestionsPageState extends State<AddQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuestionsCubit>()
        ..init()
        ..selectLaw(widget.law.id),
      child: BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null) {
            print(state.failure!.message);
            return Center(child: Text('Error: ${state.failure!.message}'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Law Header & Levels Bar Section
                _buildHeader(context, state),
                const SizedBox(height: 24),

                // 2. Add Question Form Section
                AddQuestionForm(
                  materials: state.materials,
                  onAddQuestion: (question) {
                    final qToAdd = question.copyWith(
                      lawId: widget.law.id,
                      level: state.selectedLevel,
                    );
                    context.read<QuestionsCubit>().addNewQuestion(qToAdd);
                  },
                ),
                const SizedBox(height: 32),

                // 3. Questions List Section
                QuestionsListSection(
                  questions: context.read<QuestionsCubit>().filteredQuestions,
                  onToggleStatus: (id, isActive) => context
                      .read<QuestionsCubit>()
                      .toggleQuestionActive(id, isActive),
                  onDelete: (id) =>
                      context.read<QuestionsCubit>().removeQuestion(id),
                  onSearch: (q) =>
                      context.read<QuestionsCubit>().updateSearch(q),
                ),
                const SizedBox(height: 32),

                // 4. Action Buttons Section
                _buildActionButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, QuestionsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back_ios, size: 20),
            ),
            const Icon(Icons.gavel_outlined, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              widget.law.name,
              style: AppTextStyles.font20BoldBlack.copyWith(
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LawLevelsBar(
          totalLevels: widget.law.totalLevels,
          selectedLevel: state.selectedLevel,
          onLevelChanged: (level) =>
              context.read<QuestionsCubit>().selectLevel(level),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SaveQuestionsPopup(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.grey100,
              foregroundColor: AppColors.grey500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'حفظ',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ShareQuestionsPopup(
                  lawName: widget.law.name,
                  onShare: () {
                    // Logic to share/publish can be added here
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'نشر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
