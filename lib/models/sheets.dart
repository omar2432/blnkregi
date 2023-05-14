import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import './user.dart';

// create credentials
const _credentials= r'''
{
  "type": "service_account",
  "project_id": "flutter-gsheets-blnk",
  "private_key_id": "3e9cee64ac86532076fb77cd26b8b3f1ca15f1c2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCbopDQL6X9N2Z9\nIKvKUzb/yEPhZu5fFIbWUgtIX0kLQ1wqJe/nCE7/9XGjbVeTyDDeWp1vmb4bvmJA\n3mpsFLBH7CqhKJjdY218Q0bHapmhpP2XgbT0360vEiUfgIelC0zDVGog8xD+nwvM\nf+qkgy4wa/E6ZL6cRGVroLTvfyirwOgrC3S6j4FjvNSiJihfyfbi2vy6mtWR72x8\nKbtPEgsxlcRzmlW1K1+kJMPC9om6pC5IfXlblk6IWhwTwlhRQBQsDBvn9gICrFVc\nRQc89svuVCd1ShX+KmB4DoiKkd4VS1GW6daxcX9u4mLSbwAn6i1BnbztOoCRCKmQ\nS2CMbI/dAgMBAAECggEABOfaJDHIS+O954ZK2/EFDAlyOE3gCB+zw1gpMmIMgZ4h\nLtPszK26nb9NEm9tIgOepLea/ExOjX3SB4TrOlZpmw7C5jsLHHlYl2Dgf4Mo7gsv\nEiI8w7Y0NYZfJK/OtsFVLVgBE2JOABSf0NWcXgyjfVO9sg9AYdkXEE4rvdvWeplo\npbX7AIHfjiCuItjj/ILs5AIWyLP1A6mjTnsostmkipny2Ob86LTkt3hMgnJHVLnt\n3nIEly/3mvxvbItwF+FRnXuFljxWwjm3VtfD6tU7JcYVSZhdBYf4nAZrQo9PwRSt\nGwvJ08I4MLlWQyvz3Op4BdqO6dPhPcTBHL6h47F6+QKBgQDaUnG4zOFgmjyCpgxk\n8uoIylCAytB4nhDN7ACIaI3uwRtn/VAm6l+h4Iv1BZd9SWS7K0CR1gsrzGYVrpon\nKKFJdBIEXZTzO+korym47HW2W+Nn7mQlu6+XyDo8rumvMT9zcyHFaQch2Bppaxor\n5sbLB6o4si0Xq+WkOe5rEbo8FQKBgQC2fpVezLNLUxeCGHnzVbYl7sfKj/8wygaW\n3W7amiKoIrc3Ff0fzdNXWy/4AfWlbacaFsbcR+oG017EcCQ9gwj/OdWWUNsQQWvU\nZxNXqKDPzRc8LKFkm7UK7PuzTs5oCLTBdFDGBeR4TVIXZIQyDTvtuhyQmz6ZjG/2\nb3Vy2hrOqQKBgBTd/HClZIVPOKlkJZsgfK4KaFdnCzX8Ja8I96QSGj7PxkbSN28A\nx9M5Gyd4OVqIQVCCedF2m+q7xqYb4jAL+h6DMZWpPCtjdo2k8F/0eevMLJgqePgC\nUG45fRd/wGY2VtI6Fug/eacKeLvKuN2pWSbevK5emWDB1Vk1EEy7jQlhAoGBAJFA\n0Z0h6vdiTIzE9JPkvdUVaDpnQKPRuUrtNqWSF1GiSBf1TYK57aRTNSv+S0n/rAhM\n5r1AFBqYtI4//+hh2pBitQkulB4tJClsXW3hDxY21G6Vy2Prtz7Z/0Dp0cnmXBC6\nhuwGlqHWUSfDXqED/ZYrEz9aAYpvyFHqxx3CUaH5AoGAMaf4p2Oj2w16smITEUOf\nOZxTaEus7sVYU3VMgT6zOQNMTQlUmp8cHMuKm019bqsVEI9KaQnacu8B/hct1gm1\nAlpHUEETkKtM3D9p+SJRlIkXAw1WxXZ5kpAXuFvzMQGKxP+2YAt3vOv9RFKkzXZ9\nT8cgfrIll3KiQE+9Xuo3lII=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-blnk@flutter-gsheets-blnk.iam.gserviceaccount.com",
  "client_id": "111451914890516613233",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-blnk%40flutter-gsheets-blnk.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

// spread sheet ID

const _spreadSheetId='17mVXkwKUIhnV9oM3VpTUUsMeblaY7rolxZCxKbMX0y4';

class Sheets{

  static void initSheets(User newuser) async{

    //init Gsheets
    final gsheets= GSheets(_credentials);
    
    //fetch spreadsheet by ID
    final ss=await gsheets.spreadsheet(_spreadSheetId);
    
    // get worksheet by its title
    var sheet =ss.worksheetByTitle('Sheet1');
    

    await sheet!.values.appendRow([newuser.firstName,newuser.lastName,newuser.address,newuser.area,newuser.landline,newuser.mobile,newuser.idFront,newuser.idBack]);
    
  }
}