import 'package:googleapis_auth/auth_io.dart';

class GetServerKey{

  Future<String>getServerKeyToken() async{
    final scopes=[
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',

    ];
    final client =await clientViaServiceAccount(ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "notification-19a1e",
      "private_key_id": "3618815265b35f9b1032ea1b388c381e936d5045",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC19nE+UGgOS/5Z\n8TMm4nNTnYgNIKax+/nQyJJ9FJL61UPhk1PqOo9YZoBUQMYYbFiovVq0RQX+dh0m\nHiO/hKn8u+wNPjwmB2JAVxhhqTzLaQ/Kggb9cxxy1XFNqoapdHHF7RkFvFPKmemJ\n2esPJ4gyDog822jhLUSiCKxAGszjdEQuwvx+GtgzrUH+SmgOvQxYiDcnV8OOzmeb\nKPNvgjlDWTpDhlTbsN0gjQD/B67pBkO9VVFQYA2RsOkSU06woJfo3Ti8dp4MoylY\niucvT7JzGhMNuK6ElSOEHZvd9vwdej+IoLc0FRNT8G/0wITTpBfaDtNntEBqqTtT\n3voo+9D9AgMBAAECggEANkIUJnancIvsfjlT/WZM6UPyC6gOzMfMCBumwrFd2nm5\nUgwyW4e2sq9t2LGv4Bx+m2JLJ7HlRalGq9UU58jRP1Fx48kI+nX9MB5IYOasACOF\n1+bJ2s12UC+hJ32Pxfu46UH30iQEAEfAwaA/XTd2fyaiLTNnpK1w57gaVMspCTFj\nMSwOZwQyRszMNHWiUG1BsUDqAe1rwpZW1IoZnt8k9P52xpR72adhnRMiC2Rbxy6m\n0WObT2m3V3v4yjoXDfDqyzBAyaAirov3nF/ujV6ZYFjZsm0SMcrODcJwZZwJT4H5\n7PJMx9ar0AH+Vst0iW3yg8S+8BO1fHNuTc4WpMEqaQKBgQDkMKeOExOeXSERYFXf\nAQ9iD38T1Ti9i3te3qaW51xvErQGnd+4KqcfGmdadz+Kqfl8WcGSQbKBlCOTXV/2\nxYUbK9IcaKz0HWLycsNprUvYQbdJB8Xkf62cByVRWwWIUT9TI7Rljeu/meFj4z47\nfxEQpDwRCaU+IVhIOxi7biesewKBgQDMI4fTgn7dQq/jJ0V7sM4ZZImolsx/Zbrs\nt5JJ+DHlfRQH2m1ivEL/s44Rp72RUqRRzYzs129WlENrynL/x//xAzgsyFArpEjA\n6iJrEn4rlXeDRD3sLDD4RYzr5xma13qzm1Zn/u8kN6NINpWoMFwPs+hCmwR7dY5T\nhdBGFLkq5wKBgQCpDQKU1r0qDYR6Awya8YYb968FWml2wubbGcgA89Ye05RbcopT\nPgYhnMYE12NTrykNXtFxMQq1xLG2cu6tOxepUYWPVl0LXNn5E9yBZclSpRzMFd4d\nshlEBmc3Jl+q5cYsKb9znPiSMcYw4iEwoqpZ0dJOLP8mUD2/BUkFUk5CEQKBgHns\nBqWW3Pp9Z9t9iwxTDuUvnOAqIL0+HyReh2rSZ8qup5YBKS+9TS63KPT2gEwZVbbd\n03tpOEA3kQUCBykpZH2n9JcalHdcSW+e5yuYAe85+AVYbrttsVm3AHGstyg55jj7\nX+IA6wdwi38Hyt6G85UVWHTfbQ/nqDfORhR1MBqlAoGAEvISv1kLRjbPSP1V6JPO\n0i5Tr737cjwiPa5Tk/TRhV23524ZbEKC+uX936mfAWANmcQRqa3GxKq0WDLeJ1e7\nZhkoFkO1rM21pAhvfz7CSOIaB5gcUe5Nnrjxt1MyNcj75GohIoZiDfW3KmWFCUyJ\nz19IA3oEmlqvWPqZhcZ+y9I=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-o6em9@notification-19a1e.iam.gserviceaccount.com",
      "client_id": "100310378921798788910",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-o6em9%40notification-19a1e.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }), scopes);

    final accessServerKey=client.credentials.accessToken.data;

    return accessServerKey;
}
}