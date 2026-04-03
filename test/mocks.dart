import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:veloroute_app/data/dataproviders/transport_data_client.dart';
import 'package:veloroute_app/domain/repositories/i_transport_repository.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockDataClient extends Mock implements TransportDataClient {}
class MockTransportRepository extends Mock implements ITransportRepository {}
