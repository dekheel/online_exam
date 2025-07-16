import 'package:online_exam/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:online_exam/features/authentication/data/data_sources/authentication_data_source.dart';



/// AuthenticationRepositoryImpl is the concrete implementation of the AuthenticationRepository
/// interface.
/// This class implements the methods defined in AuthenticationRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AuthenticationRepositoryImpl implements AuthenticationRepository {
      
   final AuthenticationDataSource  authenticationDataSource;
   AuthenticationRepositoryImpl(this.authenticationDataSource);
}