# Work Log

## Weekly Log

#### Week of 30 December 2012
* _To do..._
 
#### Week of 23 December 2012
* Finished a good majority of the controllers (with the exception of the institutions) and corresponding tests
* A newer UI (see [the beta site](http://beta.getnotedapp.com))

#### Week of 16 December 2012
* Tweaked testing environment (using [Cane](https://github.com/square/cane) for code quality checks); cleaned specs

#### Week of 9 December 2012
* Work on user authentication
* Wrapped up most modeling (except Sources)
* Started writing tests for [noted/scholar](https://github.com/noted/scholar), an external code library to generate valid MLA citations

#### Week of 2 December 2012
* Redesigned home page again (see it on [the beta site](http://beta.getnotedapp.com))
* Continued writing controllers

#### Week of 25 November 2012
* Finish data modeling and related tests

#### Week of 18 November 2012
* Modeling nearly complete
* Refactored unit testing

#### Week of 11 November 2012
* Continuing programming

#### Week of 4 November 2012
* Worked on programming (data modeling)

#### Week of 28 October 2012
* Begun work on basic design

#### Week of 21 October 2012
* Created interim website
* Bought domain (getnotedapp.com)
* Wrote models and their corresponding tests

#### Week of 14 October 2012
* Begun work on interim website (an introduction to the project, with a form for a user to give their username in order to recieve email notifications and access to the beta in March)
* Talked to Josh at Fanzter

#### Week of 7 October 2012
* Continued planning potential features
* Wireframing, user flow diagrams
* Wrote introduction for general public (submitted to Hacker News) 

#### Week of 23 September 2012
* Surveyed potential users on their previous experience with similar products (i.e., NoodleTools)
* Week of 30 September 2012
* More surveying of potential users

<hr />


## Monthly Log

### November 2012

My biggest concern this month was refactoring my unit tests. Unit tests allow me to run the code I write and see if it does what I expect it to do. It is very important that I have enough test coverage — I need to make sure that each and every aspect of my code works, and I even need to make sure that it behaves correctly when it does fail.

I completely rethought the design of the home page, and Mr. Procko and I agreed that it'd be much better and easy to use. The design of the home page will set the tone for the rest of the site, so getting it right is important.

I looked at possibly making an API-centric application. An API, or "application programming interface" is a part of my website that provides data, essentially. Wikipedia defines it as:

> An application programming interface (API) is a source code based specification intended to be used as an interface by software components to communicate with each other. An API may include specifications for routines, data structures, object classes, and variables.

It isn't a traditional website, per se, but it does do the exact same thing, but with pure data. Making Noted API-centric would make it so that every client, or device (think computer, iPhone, etc.), would be a consumer of that API. The thought is that it is "stateless", where each call to the API is induvidual and not suited to the user — this makes it so the developer focuses more on function, not user-based actions.

I asked my Twitter followers whether I should make Noted API-centric, and a majority of the responses said that it would be good — however, I'd need much more time than I have. I'd essentially be developing two separate applications: the API and the client. I've decided to stick with the more "traditional" application model.

### October 2012

This month I seriously began work on the code. I was able to overcome the first technological hurdle: figuring out how to model citations data. I found that using Ruby's Hash class would be easy enough — it allows for flexibility, while still keeping around the features that MongoMapper provides.
 
I also began design work. I posted a screenshot of what I have for the home page so far, and I've recieved good feedback. I think I'll continue designing before I get to the actual programming. This is beneficial because I don't need to write the same code twice.
 
I interviewed Josh from Fanzter, and he brought up many points I hadn't thought of. For example, keeping user data separate and secure, how to sell this product business-to-business, liability, marketing it as a SaaS ("Software-as-a-Service"), insurance, demonstration value, marketing, billing, and support. I also talked to Mrs. Carlson and she gave me more insight as to what librarians need from this product.
 
I've realized that most of the faculty I've talked to want a more structured system (teachers have more privileges than students, teachers have the ability to organized notecards, etc.), while students want an unstructured, do-it-yourself like system. I believe that it would be better to have everyone on the same level, teachers included. I also would like students to have the flexibility to organize how they'd like to&mdash;often times the way a teacher organizes is not right for me.
 
I need to speed up the pace I'm iterating on this project. If I want to have a working version by March, I need to be working faster&mdash;there are many hurdles ahead. Hopefully after this month (and college applications) are over I'll have more time.

### September 2012

Though the thought processes for this project started months ago, I only began to flesh out specific details this month. My goal for the past four weeks was to see what exactly students, teachers, and librarians required from such a tool. Looking at what we currently use and weighing the pros and cons is especially helpful.

Some of the features I thought would be useful turned out not to be such. For example, I thought it would be helpful to have handwriting recognition&mdash;if you weren’t too comfortable with taking notes on a keyboard, you can handwrite them, scan them into the computer and upload it to the site. After some interviewing with people, I’ve come to the conclusion that this is far more trouble than it’s worth, both for me and the user.

I’ve gotten great feedback on the project, and people seem to be actually excited about the prospect of a better tool. This genuine interest shows me that I might have a user base for this product.

I am right on schedule for my self-imposed due-by dates. I’ve begun the basic programming for the website, and I’ve thought about what kind of branding and user experience design I’d put into the site. I’ve also made wireframes to plan what exactly it will take a user to do a specific action (for example, what steps it would take to sign up for the site, or make a source, etc). About two weeks into October, I plan to begin seriously programming all of the actions of the site. It will hopefully be barely functional soon.
