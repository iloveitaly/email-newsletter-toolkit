# Templates

I've boiled down my email needs into two templates:

* **Personal** - used
* **Generic** - composed of three main areas: 1) preheader 2) content area 3) footer. The content area has many types of content blocks:
  * Simple text block
  * Framed text
  * 1/4 + 3/4 split
  * 1/2 + 1/2 split
  * 3/4 + 1/4 split
  * Three column even split
  * Three column even split, padded
  * Three column even split, padded, with images
  * RSS Notification
  * RSS Digest

# Services Used

I use MailChimp and Mandrill as my Email Service Provider. The templates here work out of the box with those providers but could be easily modified to work with others.

Below are some resources I've collected that have helped me in my email development process.

## Inspiration
Some great resources for getting inspired.

* http://reallygoodemails.com/
* http://inspiration.mailchimp.com/
* http://campaignmonitor.com/gallery/
* http://dribbble.com/tags/email
* http://htmlemailgallery.com/


## Development
### Resources
* http://www.emailology.org/ – Hasn't been updated in a while, but has some great resources.
* https://github.com/seanpowell/Email-Boilerplate/ – hasn't been updated in a while, but still has some good pointers.
* https://stamplia.com/ - Email template marketplace
* http://litmus.com/

### Components / Tools
* https://www.sendwithus.com/resources/components – some great snippets
* https://github.com/premailer/premailer – CSS inliner. MailChimp, Mandrill, and most ESPs do this automatically. However, if you push transactional emails from a web app that uses plain SMTP there is a rails gem which allows you to more easily create nice looking HTML emails from your web app.
* http://buttons.cm/ – HTML button generator


### Frameworks / Templates
* http://internations.github.io/antwort/
* https://github.com/leemunroe/html-email-template – simple, responsive email template
* https://github.com/leemunroe/html-email-template – simple, responsive email template
* http://zurb.com/ink/ – more robust responsive email templates
* https://github.com/patrickocoffeyo/ModernMail
* http://briangraves.github.io/ResponsiveEmailPatterns/ - Collection of patterns for responsive HTML emails

## Snippets

## Intergrations, Third Party Tools, etc
* ["Refer a friend" email system without any code](http://us2.campaign-archive1.com/?u=b5af47765edbd2fc173dbf27a&id=154e871003&e=2c26939165)
* [Cheap, easy, customizable text to subscribe system with MailChimp and Twilio](https://github.com/iloveitaly/Twilio-to-MailChimp-Subscription)
* [Convert a YouTube video link into a HTML email friendly image](https://github.com/iloveitaly/youtube-thumbnail-enhancer)

## Services
Aside from MailChimp, here are some tools which I haven't used but look like they have great potential.

* https://getdrip.com/ – integrates with MailChimp
* https://www.sendwithus.com/ – marketing-managed transactional emails
* http://outbound.io/, http://customer.io/ – automated email messages based on customer action
* http://www.sailthru.com/
