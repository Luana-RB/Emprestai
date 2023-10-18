import 'package:appteste/models/posts/post_generico.dart';

Map<String, Post> dummyPosts = {
  '1': Post(
    id: '1',
    status: 'Solicitado',
    title: 'Anel de plástico',
    imageUrl:
        'https://photo-cdn2.icons8.com/Hgw_bromz7wCKDs0oanDx4jUp0V5qwAmJgUkCUsgpvs/rs:fit:1613:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5l/eHRlcm5hbC9hMmE0/Mi84ODA5MDg0MDBk/MzE0MDU5OWQwM2Ji/YzBhYWYwYzQwMi5q/cGc.jpg',
    description: 'Descrição de um anel de plástico com rede',
    creatorId: '3',
    //creatorProfileLink: 'exemplo',
    //creatorImageUrl: 'https://cdn-icons-png.flaticon.com/512/1468/1468166.png',
    ownerName: 'exemplo',
    //ownerProfileLink: 'exemplo',
    //ownerImageUrl: 'https://cdn-icons-png.flaticon.com/512/1468/1468166.png',
    dateOfLending: DateTime(2023, 10, 31),
    //dateOfReturning: 'exemplo',
  ),
  '2': Post(
    id: '2',
    status: 'Devolvido',
    title: 'Guirlanda de Natal',
    imageUrl:
        'https://photo-cdn2.icons8.com/PLxdvW6trezV5vS8UZ-UxhL0JDB2GMVXnxNdL19RymE/rs:fit:1608:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5l/eHRlcm5hbC9hMmE0/Mi8xMjQwYzdjOThi/ZjI0YWQyYjc4YTU2/NGNmMjMyMmQxOC5q/cGc.jpg',
    description: 'Para decoração de uma porta de uma casa',
    creatorId: '3',
    // creatorProfileLink: 'exemplo',
    //creatorImageUrl: '',
    //ownerName: '',
    //ownerProfileLink: '',
    //ownerImageUrl: '',
    dateOfLending: DateTime.now(),
    //dateOfReturning: '',
  ),
  '3': Post(
    id: '3',
    status: 'Solicitado',
    title: 'Lâmpada de sorvete',
    imageUrl:
        'https://photo-cdn2.icons8.com/lh0BX_8i5H_XJ1dZO4PtsHIrbcI_SnSaKz9RnQ8P-js/rs:fit:288:431/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5h/c3NldHMvYXNzZXRz/L3NhdGEvb3JpZ2lu/YWwvODQzL2Q5ZjVj/NTA5LTEyYjgtNDlm/OS05YWIzLWI2NzAz/OWY0ZDRmMy5qcGc.webp',
    description: 'Para decoração de uma porta de uma casa',
    creatorId: '4',
    // creatorProfileLink: 'exemplo',
    //creatorImageUrl: '',
    //ownerName: '',
    //ownerProfileLink: '',
    //ownerImageUrl: '',
    dateOfLending: DateTime.now(),
    //dateOfReturning: '',
  ),
};
