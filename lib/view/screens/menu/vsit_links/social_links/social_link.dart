
import 'package:url_launcher/url_launcher.dart';
//lnvite friend

//facebook link
void launchFacebookPage() async {
  final facebookPageUrl = 'https://www.facebook.com/your_page_username_or_id';
  if (await canLaunchUrl(Uri.parse(facebookPageUrl))) {
    await launchUrl(Uri.parse(facebookPageUrl));
  } else {
    throw 'Could not launch Facebook page';
  }
}

//instagram link
void launchInstagramProfile() async {
  final instagramProfileUrl =
      'https://www.instagram.com/your_profile_username/';
  if (await canLaunch(instagramProfileUrl)) {
    await launch(instagramProfileUrl);
  } else {
    throw 'Could not launch Instagram profile';
  }
}
