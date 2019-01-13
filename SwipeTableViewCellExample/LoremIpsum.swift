//
//  LoremIpsum.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 13.01.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class LoremIpsum {
    private static let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam porta fermentum urna, a porta augue tincidunt et. Phasellus rutrum nunc a odio mattis, eu sodales nibh porttitor. Fusce nunc est, laoreet vitae mi eget, molestie bibendum quam. Sed faucibus euismod turpis. Vestibulum placerat nisl nec nunc malesuada placerat. Suspendisse nec accumsan lorem, id pellentesque lacus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In hac habitasse platea dictumst. Cras non arcu augue. Aenean ut suscipit erat. Duis bibendum auctor varius. Nulla aliquam augue ut justo tempus consectetur. Sed ullamcorper tristique nunc, vitae accumsan risus rutrum nec. Sed accumsan maximus consectetur. Morbi eleifend dapibus velit quis rhoncus. Fusce ullamcorper bibendum metus nec dapibus. Phasellus fringilla lectus in sem bibendum, et sagittis odio elementum. Donec pharetra sollicitudin pharetra. Aliquam accumsan metus et ipsum eleifend, a pretium nisi sagittis. Mauris ornare non urna eget vestibulum. Phasellus quam metus, pulvinar quis eros mattis, lacinia condimentum risus. Praesent aliquet, velit facilisis auctor finibus, sapien odio convallis ipsum, a maximus arcu orci a nunc. Phasellus finibus a tellus vitae ultrices. Vestibulum vestibulum tellus quis urna feugiat, sit amet suscipit erat ornare. Proin mi mi, lacinia ut ex vel, sagittis viverra mauris. Fusce tincidunt mauris quis eros ultrices, non ultricies dui blandit. Cras dictum, risus blandit lobortis fringilla, sapien odio dignissim justo, in iaculis ligula massa a tortor. Fusce molestie fermentum mi, commodo efficitur orci. Quisque ligula ipsum, sollicitudin vel venenatis et, elementum vel lorem. Etiam a augue facilisis, aliquet augue sit amet, aliquet odio. Morbi porttitor tempus arcu, ac blandit justo eleifend tristique. Sed malesuada eu sapien et congue. Aenean id pharetra tortor. Quisque mollis pulvinar ligula, nec pulvinar dui lacinia vel. Integer iaculis gravida viverra. Fusce nisi eros, porttitor vel condimentum placerat, cursus quis justo. Nunc ullamcorper, nisl sit amet vestibulum condimentum, metus justo fermentum erat, nec pulvinar nibh massa sed libero. Aliquam maximus turpis sit amet enim luctus, nec imperdiet neque aliquet. Aenean cursus porttitor iaculis. Quisque in libero sit amet lacus aliquet commodo. Nam eget egestas eros. Sed pharetra magna in massa dapibus, ut porta metus aliquam. Fusce sed vulputate libero, et fringilla mi. Nunc cursus dignissim ultricies. Proin tristique velit a lectus porta, vel bibendum mauris tristique. Fusce enim purus, luctus vel nibh at, sagittis feugiat purus. Suspendisse tempor neque eu justo malesuada feugiat. Aliquam id leo eget elit porta maximus. Duis a euismod orci. Duis ultrices in nisi eu hendrerit. Nam posuere nunc id eros venenatis, nec ullamcorper sapien bibendum. Integer finibus, purus et fermentum condimentum, sem elit scelerisque dui, non gravida risus sapien eu odio. Aliquam ac commodo dui. Nunc porta sit amet ipsum molestie commodo. Nunc dapibus est urna, ut dictum nunc pulvinar in. Cras malesuada sagittis felis in commodo. Maecenas in porttitor lectus. Duis sit amet neque nec risus aliquam interdum dignissim volutpat nibh. Nam ut odio efficitur, tincidunt neque ut, dignissim lacus."
    
    static func randomTextWithLength(_ length: Int) -> String {
        if length >= loremIpsum.count {
            return loremIpsum
        }
        
        let start = arc4random_uniform(UInt32(loremIpsum.count - length))
        let index = loremIpsum.index(loremIpsum.startIndex, offsetBy: Int(start))
        let range = index..<loremIpsum.index(index, offsetBy: length)
        let resultSubstring = loremIpsum[range]
        return String(resultSubstring)
    }
}
