import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/law_entity.dart';
import '../../domain/repositories/laws_repository.dart';
import '../datasources/laws_remote_data_source.dart';
import '../models/law_model.dart';

class LawsRepositoryImpl implements LawsRepository {
  final LawsRemoteDataSource remoteDataSource;

  LawsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LawEntity>>> getLaws({
    int limit = 10,
    LawEntity? lastLaw,
  }) async {
    try {
      final remoteLaws = await remoteDataSource.getLaws(
        limit: limit,
        lastLaw: lastLaw != null ? LawModel.fromEntity(lastLaw) : null,
      );
      return Right(remoteLaws.map((model) => model.toDomain()).toList());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getLawsCount() async {
    try {
      final count = await remoteDataSource.getLawsCount();
      return Right(count);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getActiveLawsCount() async {
    try {
      final count = await remoteDataSource.getActiveLawsCount();
      return Right(count);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLaw(LawEntity law) async {
    try {
      await remoteDataSource.addLaw(LawModel.fromEntity(law));
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
