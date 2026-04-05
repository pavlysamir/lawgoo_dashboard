import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/law_material_entity.dart';
import '../../domain/repositories/law_material_repository.dart';
import '../datasources/law_material_remote_datasource.dart';
import '../models/law_material_model.dart';

class LawMaterialRepositoryImpl implements LawMaterialRepository {
  final LawMaterialRemoteDataSource remoteDataSource;

  LawMaterialRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LawMaterialEntity>>> getLawMaterials(
    String lawId, {
    int limit = 10,
    LawMaterialEntity? lastMaterial,
    String? searchQuery,
  }) async {
    try {
      final remoteMaterials = await remoteDataSource.getLawMaterials(
        lawId,
        limit: limit,
        lastMaterial: lastMaterial != null
            ? LawMaterialModel.fromEntity(lastMaterial)
            : null,
        searchQuery: searchQuery,
      );
      return Right(remoteMaterials.map((model) => model.toDomain()).toList());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getLawMaterialsCount(String lawId) async {
    try {
      final count = await remoteDataSource.getLawMaterialsCount(lawId);
      return Right(count);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLawMaterial(LawMaterialEntity material) async {
    try {
      await remoteDataSource.addLawMaterial(LawMaterialModel.fromEntity(material));
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLawMaterial(
      LawMaterialEntity material) async {
    try {
      await remoteDataSource
          .updateLawMaterial(LawMaterialModel.fromEntity(material));
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteLawMaterial(String materialId) async {
    try {
      await remoteDataSource.deleteLawMaterial(materialId);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
