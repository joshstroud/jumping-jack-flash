# Josh Stroud GitHub: github.com/joshstroud

### This project was written in 2009-2010

When I was in high school, I was interested in applying some of my AP Physics C knowledge to a game engine. I had experience as a game developer at uWink, a company for video games in restaurants. I had applied and was accepted to their UNPAID internship program as a high school student.

Often, I get asked: how do I break into my first job in engineering? My advice is to work for free as soon as possible, and then leverage that to get your first paid internship.

It was back-breaking work. I worked long hours over a hot compiler, late into the night :) Not really, but it was fun! I went twice a week after school - fitting for a young student in the CTO life :)

This repo outlines building a successful physics engine using Flash, an animation software with heavy scripting elements that was popular in the 2000s and 2010s. Eventually, Flash became insecure, and it fell out of vogue. No one uses it any more, or even allows it into their web browser (Looking at you, Safari).

Later, I felt that it was important to make this code work in a modern programming framework. Over 2024, I hacked away at it, and built a Javascript engine which uses Canvas to run the engine. Thanks for the Javascript elements, ActionScript!

Josh Stroud
CEO, agilend
agilend.net

### Thoughts on Flash - https://en.wikipedia.org/wiki/Thoughts_on_Flash

"Steve Jobs of Apple says:"

Apple has a long relationship with Adobe. In fact, we met Adobe’s founders when they
were in their proverbial garage. Apple was their first big customer, adopting their
Postscript language for our new Laserwriter printer. Apple invested in Adobe and owned
around 20% of the company for many years. The two companies worked closely
together to pioneer desktop publishing and there were many good times. Since that
golden era, the companies have grown apart. Apple went through its near death
experience, and Adobe was drawn to the corporate market with their Acrobat products.
Today the two companies still work together to serve their joint creative customers –
Mac users buy around half of Adobe’s Creative Suite products – but beyond that there
are few joint interests.

I wanted to jot down some of our thoughts on Adobe’s Flash products so that customers
and critics may better understand why we do not allow Flash on iPhones, iPods and
iPads. Adobe has characterized our decision as being primarily business driven – they
say we want to protect our App Store – but in reality it is based on technology issues.
Adobe claims that we are a closed system, and that Flash is open, but in fact the
opposite is true. Let me explain.

### First, there’s “Open”.

Adobe’s Flash products are 100% proprietary. They are only available from Adobe, and
Adobe has sole authority as to their future enhancement, pricing, etc. While Adobe’s
Flash products are widely available, this does not mean they are open, since they are
controlled entirely by Adobe and available only from Adobe. By almost any definition,
Flash is a closed system.

Apple has many proprietary products too. Though the operating system for the iPhone,
iPod and iPad is proprietary, we strongly believe that all standards pertaining to the web
should be open. Rather than use Flash, Apple has adopted HTML5, CSS and JavaScript –
all open standards. Apple’s mobile devices all ship with high performance, low power
implementations of these open standards. HTML5, the new web standard that has been
adopted by Apple, Google and many others, lets web developers create advanced
graphics, typography, animations and transitions without relying on third party browser
plug-ins (like Flash). HTML5 is completely open and controlled by a standards
committee, of which Apple is a member.

Apple even creates open standards for the web. For example, Apple began with a small
open source project and created WebKit, a complete open-source HTML5 rendering
engine that is the heart of the Safari web browser used in all our products. WebKit has
been widely adopted. Google uses it for Android’s browser, Palm uses it, Nokia uses it,
and RIM (Blackberry) has announced they will use it too. Almost every smartphone web 
browser other than Microsoft’s uses WebKit. By making its WebKit technology open,
Apple has set the standard for mobile web browsers.

### Second, there’s the “full web”.

Adobe has repeatedly said that Apple mobile devices cannot access “the full web”
because 75% of video on the web is in Flash. What they don’t say is that almost all this
video is also available in a more modern format, H.264, and viewable on iPhones, iPods
and iPads. YouTube, with an estimated 40% of the web’s video, shines in an app
bundled on all Apple mobile devices, with the iPad offering perhaps the best YouTube
discovery and viewing experience ever. Add to this video from Vimeo, Netflix, Facebook,
ABC, CBS, CNN, MSNBC, Fox News, ESPN, NPR, Time, The New York Times, The Wall
Street Journal, Sports Illustrated, People, National Geographic, and many, many others.
iPhone, iPod and iPad users aren’t missing much video.

Another Adobe claim is that Apple devices cannot play Flash games. This is true.
Fortunately, there are over 50,000 games and entertainment titles on the App Store,
and many of them are free. There are more games and entertainment titles available for
iPhone, iPod and iPad than for any other platform in the world.

### Third, there’s reliability, security and performance.

Symantec recently highlighted Flash for having one of the worst security records in
2009. We also know first hand that Flash is the number one reason Macs crash. We
have been working with Adobe to fix these problems, but they have persisted for several
years now. We don’t want to reduce the reliability and security of our iPhones, iPods and
iPads by adding Flash.

In addition, Flash has not performed well on mobile devices. We have routinely asked
Adobe to show us Flash performing well on a mobile device, any mobile device, for a few
years now. We have never seen it. Adobe publicly said that Flash would ship on a
smartphone in early 2009, then the second half of 2009, then the first half of 2010, and
now they say the second half of 2010. We think it will eventually ship, but we’re glad we
didn’t hold our breath. Who knows how it will perform?

### Fourth, there’s battery life.

To achieve long battery life when playing video, mobile devices must decode the video
in hardware; decoding it in software uses too much power. Many of the chips used in
modern mobile devices contain a decoder called H.264 – an industry standard that is
used in every Blu-ray DVD player and has been adopted by Apple, Google (YouTube),
Vimeo, Netflix and many other companies. 

Although Flash has recently added support for H.264, the video on almost all Flash
websites currently requires an older generation decoder that is not implemented in
mobile chips and must be run in software. The difference is striking: on an iPhone, for
example, H.264 videos play for up to 10 hours, while videos decoded in software play
for less than 5 hours before the battery is fully drained.

When websites re-encode their videos using H.264, they can offer them without using
Flash at all. They play perfectly in browsers like Apple’s Safari and Google’s Chrome
without any plugins whatsoever, and look great on iPhones, iPods and iPads.
Fifth, there’s Touch.

Flash was designed for PCs using mice, not for touch screens using fingers. For
example, many Flash websites rely on “rollovers”, which pop up menus or other
elements when the mouse arrow hovers over a specific spot. Apple’s revolutionary
multi-touch interface doesn’t use a mouse, and there is no concept of a rollover. Most
Flash websites will need to be rewritten to support touch-based devices. If developers
need to rewrite their Flash websites, why not use modern technologies like HTML5, CSS
and JavaScript?

Even if iPhones, iPods and iPads ran Flash, it would not solve the problem that most
Flash websites need to be rewritten to support touch-based devices.
Sixth, the most important reason.

Besides the fact that Flash is closed and proprietary, has major technical drawbacks,
and doesn’t support touch based devices, there is an even more important reason we do
not allow Flash on iPhones, iPods and iPads. We have discussed the downsides of using
Flash to play video and interactive content from websites, but Adobe also wants
developers to adopt Flash to create apps that run on our mobile devices.

We know from painful experience that letting a third party layer of software come
between the platform and the developer ultimately results in sub-standard apps and
hinders the enhancement and progress of the platform. If developers grow dependent
on third party development libraries and tools, they can only take advantage of platform
enhancements if and when the third party chooses to adopt the new features. We
cannot be at the mercy of a third party deciding if and when they will make our
enhancements available to our developers. 

This becomes even worse if the third party is supplying a cross platform development
tool. The third party may not adopt enhancements from one platform unless they are
available on all of their supported platforms. Hence developers only have access to the
lowest common denominator set of features. Again, we cannot accept an outcome
where developers are blocked from using our innovations and enhancements because
they are not available on our competitor’s platforms.

Flash is a cross platform development tool. It is not Adobe’s goal to help developers
write the best iPhone, iPod and iPad apps. It is their goal to help developers write cross
platform apps. And Adobe has been painfully slow to adopt enhancements to Apple’s
platforms. For example, although Mac OS X has been shipping for almost 10 years now,
Adobe just adopted it fully (Cocoa) two weeks ago when they shipped CS5. Adobe was
the last major third party developer to fully adopt Mac OS X.

Our motivation is simple – we want to provide the most advanced and innovative
platform to our developers, and we want them to stand directly on the shoulders of this
platform and create the best apps the world has ever seen. We want to continually
enhance the platform so developers can create even more amazing, powerful, fun and
useful applications. Everyone wins – we sell more devices because we have the best
apps, developers reach a wider and wider audience and customer base, and users are
continually delighted by the best and broadest selection of apps on any platform.

### Conclusions.

Flash was created during the PC era – for PCs and mice. Flash is a successful business
for Adobe, and we can understand why they want to push it beyond PCs. But the mobile
era is about low power devices, touch interfaces and open web standards – all areas
where Flash falls short.

The avalanche of media outlets offering their content for Apple’s mobile devices
demonstrates that Flash is no longer necessary to watch video or consume any kind of
web content. And the 250,000 apps on Apple’s App Store proves that Flash isn’t
necessary for tens of thousands of developers to create graphically rich applications,
including games.

New open standards created in the mobile era, such as HTML5, will win on mobile
devices (and PCs too). Perhaps Adobe should focus more on creating great HTML5 tools
for the future, and less on criticizing Apple for leaving the past behind.

*__Steve Jobs__*
__April, 2010__
