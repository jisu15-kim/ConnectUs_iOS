//
//  DummyImage.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/28.
//

import Foundation

struct DummyImage {
    static var dummyImageUrl = ["https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/job405-ploy-01c.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=9c5adbe911a650a1160fda3b45946694",
    "https://images-prod.dazeddigital.com/640/azure/dazed-prod/1140/3/1143268.jpg", "https://assets.vogue.com/photos/6331c1b3d901b74ef5bbc77b/master/pass/lafw-voguebus-photographer-month-22-story.jpg",
    "https://media.newyorker.com/photos/5d76e037114fd60008b8c9dd/master/w_1600%2Cc_limit/Patterson-NYFW-Secondary-6.jpg",
    "https://previews.123rf.com/images/rawpixel/rawpixel1612/rawpixel161239832/67631432-african-man-smiling-face-expression-concept.jpg",
    "https://www.ukg.com/sites/default/files/styles/ukg_max_width_1600px/public/2022-11/HR%20UKG%20People%20Strategy.jpg.webp?itok=yU__2WmJ", "https://imageio.forbes.com/specials-images/imageserve/717085855/960x0.jpg?format=jpg&width=960", "https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://w0.peakpx.com/wallpaper/184/496/HD-wallpaper-city-portrait-city-skyline-sunset-sky-ocean-america-portrait-view.jpg", "https://images.unsplash.com/photo-1610124734968-a52252d732e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2l0eSUyMHBvcnRyYWl0fGVufDB8fDB8fA%3D%3D&w=1000&q=80"]
    static var randomDummyImage = dummyImageUrl.shuffled()
}
