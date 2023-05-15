# tourmeapp_ios

## Architecture
- SwiftUI, Swift, Combine
- MVVM Architecture
- CocoaPods

### CocoaPods
What is CocoaPods?
CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 95 thousand libraries and is used in over 3 million apps. CocoaPods can help you scale your projects elegantly.

For more information, see: https://cocoapods.org/

## Tour Content
TourMeApp content is kept in the tourmeappisrael AWS S3 bucket.

### Tours

Tours are kept in JSON files consistent with each of the current three languages (EN, ES, PT):
https://tourmeappisrael.s3.us-east-2.amazonaws.com/tours_EN.json
https://tourmeappisrael.s3.us-east-2.amazonaws.com/tours_ES.json
https://tourmeappisrael.s3.us-east-2.amazonaws.com/tours_PT.json

Tours are JSON based with the following format:
```
{
    "id": "c580fd45-3b12-4935-80d8-2f5373c0774c",
    "name": "Hazor",
    "language": "EN",
    "enabled": true,
    "position": {
      "lon": 35.566944,
      "lat": 33.016666
    },
    "thumbnailUrl": "https://d3aa37cj97ghel.cloudfront.net/tourmeapp/vod/hazor/thumbnails/hazor_en_01_optimized.jpg",
    "videoUrl": "https://d3aa37cj97ghel.cloudfront.net/processedpvod/64705d61-283a-4d0a-a617-2f346223a617/AppleHLS1/hazor_en_trailer.m3u8",
    "description": "Tel Hazor, one of the several amazing sites in Israel, that is recognized by UNESCO as a world heritage site, and has 21 layers of different civilizations.",
    "sortOrder": 10,
    "BusStops": {
      "items": [
        {
          "enabled": true,
          "description": "Hazor was one of the three major cities that were built by king Solomon outside of Jerusalem and contains evidence of a fire that destroyed the city and for which, Joshua himself, was responsible. ",
          "name": "Hazor 2",
          "id": "3d13c9e5-8005-47ae-9676-1a0c02295490",
          "thumbnailUrl": "https://d3aa37cj97ghel.cloudfront.net/tourmeapp/vod/hazor/thumbnails/hazor_03_optimized.jpg",
          "videoUrl": "https://d3aa37cj97ghel.cloudfront.net/processedpvod/ef41cf8c-4694-4800-aeb0-329e7b76eb7a/AppleHLS1/hazor_en_02.m3u8",
          "language": "EN"
        },
        {
          "enabled": true,
          "description": "The water system of Hazor is an amazing feat of engineering done by king Ahab and without the modern tools of today.",
          "name": "Hazor 3",
          "id": "468bef31-8c3c-495f-9cb9-9634305538a8",
          "thumbnailUrl": "https://d3aa37cj97ghel.cloudfront.net/tourmeapp/vod/hazor/thumbnails/hazor_04_optimized.jpg",
          "videoUrl": "https://d3aa37cj97ghel.cloudfront.net/processedpvod/4912d8f0-ba56-4e4a-9ef0-c03e0f53e10e/AppleHLS1/hazor_en_03.m3u8",
          "language": "EN"
        },
        {
          "enabled": true,
          "description": "Tel Hazor, one of the several amazing sites in Israel, that is recognized by UNESCO as a world heritage site, and has 21 layers of different civilizations.",
          "name": "Hazor 1",
          "id": "1fc3ac13-270c-47a9-bc11-e8082d8195ce",
          "thumbnailUrl": "https://d3aa37cj97ghel.cloudfront.net/tourmeapp/vod/hazor/thumbnails/hazor_02_optimized.jpg",
          "videoUrl": "https://d3aa37cj97ghel.cloudfront.net/processedpvod/7163e597-04e3-487c-ae01-44d795d2e558/AppleHLS1/hazor_en_01.m3u8",
          "language": "EN"
        }
      ]
    }
  }
```

- All id fields are unique GUIDs (UUID).
- Language fields must be consistent with the names of the JSON files (EN, ES, or PT).
- The `sortOrder` field determines the order of tours as they appear in the list on the screen.
- Tours and Stops may be "hidden" by setting `enabled` to `false`.

### News HomeContent

News items (`HomeContent`) are kept in JSON files consistent with each of the current three languages (EN, ES, PT):
https://tourmeappisrael.s3.us-east-2.amazonaws.com/home_content_EN.json
https://tourmeappisrael.s3.us-east-2.amazonaws.com/home_content_ES.json
https://tourmeappisrael.s3.us-east-2.amazonaws.com/home_content_PT.json

HomeContent items are JSON based with the following format:
```
{
    "id": "1",
    "buttonText": null,
    "description": "Israel as a start-up nation - when life gives you lemons, we make lemonade... Special stories and the faces behind them War heroes and personal stories of Israel's military campaigns Local chefs and cuisine Why whine, when you can wine? - Wine culture in Israel. Learn from local experts about the \"fruit of the vine\" Israeli agriculture - pushing the desert away",
    "keyword": null,
    "language": "EN",
    "thumbnailUrl": "https://d3aa37cj97ghel.cloudfront.net/tourmeapp/vod/images/zvi_filming.jpg",
    "title": "Bonus Content is on the Way",
    "sortOrder": 3,
    "showButton": false,
    "enabled": true
}
```
  
- All id fields must be unique (numberic or GUID).
- Language fields must be consistent with the names of the JSON files (EN, ES, or PT).
- The `sortOrder` field determines the order of tours as they appear in the list on the screen.
- News items may be "hidden" by setting `enabled` to `false`.

## AWS Content

### Bucket Structure

`/`:
- primary JSON files for tours and home content (news) in each primary supported language.

`processedpvod`:
- processed/optimized video files in m3u8 format. These were created using AWS MediaConvert. Any tool, including external tools, may be used. 

`tourmeapp`:
`ivs`: archived live streams
`vod`: individual tours by name of tour consisting of subfolders: `en`, `es`, `pt`, `subtitles`, and `thumbnails`. Subtitles for each tour are in numbered subfolders under `subtitles` corresponding to each video. 

### CloudFront (CDN)
A CloudFront Distribution exists to serve data in the `tourmeappisrael` S3 bucket. This root URL must replace the base URL for the AWS S3 bucket. Settings, Origins, and Behaviors are configured to allow serve HTTPS GET requests to the data in the linked S3 bucket from iOS, Android, and Web.

## Credentials

Credentials for AWS are found in the attached _Credentials_ document.
