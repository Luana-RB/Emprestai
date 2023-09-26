import 'package:appteste/models/posts/post_generico.dart';

Map<String, Post> dummyPosts = {
  '1': Post(
    id: '1',
    status: 'Solicitado',
    title: 'Anel de plástico',
    imageUrl:
        'https://photo-cdn2.icons8.com/Hgw_bromz7wCKDs0oanDx4jUp0V5qwAmJgUkCUsgpvs/rs:fit:1613:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5l/eHRlcm5hbC9hMmE0/Mi84ODA5MDg0MDBk/MzE0MDU5OWQwM2Ji/YzBhYWYwYzQwMi5q/cGc.jpg',
    description: 'Descrição de um anel de plástico com rede',
    creatorName: 'Maria',
    creatorProfileLink: 'exemplo',
    //creatorImageUrl: 'https://cdn-icons-png.flaticon.com/512/1468/1468166.png',
    //ownerName: 'exemplo',
    //ownerProfileLink: 'exemplo',
    //ownerImageUrl: 'https://cdn-icons-png.flaticon.com/512/1468/1468166.png',
    dateOfLending: 'exemplo',
    //dateOfReturning: 'exemplo',
  ),
  '2': Post(
    id: '2',
    status: 'Devolvido',
    title: 'Guirlanda de Natal',
    imageUrl:
        'https://photo-cdn2.icons8.com/PLxdvW6trezV5vS8UZ-UxhL0JDB2GMVXnxNdL19RymE/rs:fit:1608:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5l/eHRlcm5hbC9hMmE0/Mi8xMjQwYzdjOThi/ZjI0YWQyYjc4YTU2/NGNmMjMyMmQxOC5q/cGc.jpg',
    description: 'Para decoração de uma porta de uma casa',
    creatorName: 'Luana',
    creatorProfileLink: 'exemplo',
    //creatorImageUrl: '',
    //ownerName: '',
    //ownerProfileLink: '',
    //ownerImageUrl: '',
    dateOfLending: 'exemplo',
    //dateOfReturning: '',
  ),
};
