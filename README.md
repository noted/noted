# Noted.

Noted is an academic research assistant and social network.

**Authors** &mdash; [Ethan Turkeltaub](http://ethnt.me), [Earl Procko](http://www.fpsct.org/page.cfm?p=83&viewdirid=1166&showFilter=1&keyword=procko).

If you're from FHS, [here's the "Digication e-Portfolio"](https://fps.digication.com/turkeltaub-capstone). Anyone else can just read everything here.

## Proposal

My goal for capstone is to create Noted, a web-based tool to aid students and instructors with researching and collaborating on projects. This innovation project aims to help students with note-taking and source-citing process, which is now considered tedious, time-consuming work with existing products in the market such as NoodleTools and EasyBib. I will be creating the entire website, including programming, design, branding, and marketing. In the end, I plan to have built a self-sufficient web project. It will pay for itself, and perhaps even fund further projects.
 
Like many Internet startups, this idea arose out of frustration. Existing products are, by and large, not well-received by the school population. For an instructor to teach it to a student for the first time, it takes several class periods—this is a major issue. Removing this problem will also help with poor usability, terrible design, and difficult data entry, etc. Collaboration and sharing is also difficult with existing products—so rather than keep all projects private by default, everything will be public (with plagiarism deterrents) and collaboration will be as easy as asking the author for access.
 
I have been creating sites for several years, since making basic, one-page websites in sixth-grade to professional, large-scale websites at an internship at Fanzter, a startup, last summer. I aided them in creating and supporting a large, social website, several iPhone apps, and an internal tool. I have a similar amount of experience compared to web professionals in the field right now. The only technical aspect I will struggle with is handling a lot of people visiting the site at once. I’ve never really worked on a high-traffic site before. Making the website so it can handle thousands of visitors at once will be a new experience for me. Overall, technical aspects and building of the website is not very difficult for me; it’s the marketing and business aspects that will represent a learning stretch for me. The website is simple for me to build, but making it profitable is another story. The service will have a payment plan that is competitive with other products on the market, but to initially fund the project, I am considering “crowdfunding” the project through Kickstarter—a website where people can see and contribute to your project in return for services after the project is created. For advice, I can turn to the CEO at the company I interned at—he has several year experience with business at large and small web companies. Hopefully I can take experience from this course and apply it to life after college. This project is ambitious in its scale, but achievable in that I have previous experience in the web industry.
 
I need to begin by planning out who my customers are and what exactly they need in a research tool. So, I will be surveying potential customers (students, librarians, and administrators) to see what they want, and then plan out those features for the site. Then I’ll need to begin branding—logos, marketing materials, etc. Mr. Procko, my advisor, has expertise with this aspect. I also know several experts in the field that can give me some advice and help. Then I’ll begin development work and actually making the site. After, I’ll design the site and apply it to the code I made. At this point, this site will be fully functional and I’ll hopefully have some classes at Farmington High School test the site on some projects and compare it to existing products. After working out the final kinks, I’ll release it with to the public. Afterwards, I will be providing customer support for users of the product and release new features as students begin to use and give feedback.
 
This project is one I have been wanting to do for a long time. It’s only now with the resources that capstone offers and the connections I’ve made is it possible.


## Roadmap

**September** &mdash; Initial planning and research. Interview potential customers (students, teachers, librarians, etc). Begin preliminary programming.

**October** &mdash; Continue customer research. Start branding and logo design. Finish wireframing all of the site. Explore financial options.

**November** &ndash; **January** &mdash;	Program entire site. Finalize web design and branding.

**February** &mdash;	Apply design to programmed elements.

**March** &mdash; Begin beta testing—give access codes out online and to classrooms in Farmington Public Schools.

**April** &ndash; **May** &mdash; Listen to user feedback and make appropriate adjustments.

**June** &mdash; Public launch and presentation.


## Technology

I will be writing this entirely in Ruby (with either [Rails](http://rubyonrails.org) or [Padrino](http://padrinorb.com)). I intend to use [MongoDB](http://mongodb.org) for a database, [Compass](http://compass-style.com) for a SCSS framework, and [CoffeeScript](http://coffeescript.org) for compiling to JavaScript. See the [`Gemfile`](https://github.com/noted/noted/blob/master/Gemfile) for more information.

<hr />

## Weekly Log

#### Week of 23 September 2012
* Surveyed potential users on their previous experience with similar products (i.e., NoodleTools)
* Week of 30 September 2012
* More surveying of potential users

#### Week of 7 October 2012
* Continued planning potential features
* Wireframing, user flow diagrams
* Wrote introduction for general public (submitted to Hacker News) 

#### Week of 14 October 2012
* Begun work on interim website (an introduction to the project, with a form for a user to give their username in order to recieve email notifications and access to the beta in March)
* Talked to Josh at Fanzter

#### Week of 21 October 2012
* Created interim website
* Bought domain (getnotedapp.com)
* Wrote models and their corresponding tests

#### Week of 28 October 2012
* Begun work on basic design

#### Week of 4 November 2012
* _To do..._

#### Week of 11 November 2012
* Begun planning of [noted/citation](http://github.com/noted/citation). It will take the handling of turning data into citations and remove it from the primary application.

#### Week of 18 November 2012
* I am in the process of trying to figure out how to structure Noted. There are two possibilities:
  1. A standard, Ruby-based model-view-controller architecture.
  2. Separate API and browser clients (use Padrino/Grape/Espresso, etc., for server and Ember.js/Backbone/Spine, etc., for client).


## Monthly Log

### September 2012

Though the thought processes for this project started months ago, I only began to flesh out specific details this month. My goal for the past four weeks was to see what exactly students, teachers, and librarians required from such a tool. Looking at what we currently use and weighing the pros and cons is especially helpful.

Some of the features I thought would be useful turned out not to be such. For example, I thought it would be helpful to have handwriting recognition — if you weren’t too comfortable with taking notes on a keyboard, you can handwrite them, scan them into the computer and upload it to the site. After some interviewing with people, I’ve come to the conclusion that this is far more trouble than it’s worth, both for me and the user.

I’ve gotten great feedback on the project, and people seem to be actually excited about the prospect of a better tool. This genuine interest shows me that I might have a user base for this product.

I am right on schedule for my self-imposed due-by dates. I’ve begun the basic programming for the website, and I’ve thought about what kind of branding and user experience design I’d put into the site. I’ve also made wireframes to plan what exactly it will take a user to do a specific action (for example, what steps it would take to sign up for the site, or make a source, etc). About two weeks into October, I plan to begin seriously programming all of the actions of the site. It will hopefully be barely functional soon.


### October 2012

This month I seriously began work on the code. I was able to overcome the first technological hurdle: figuring out how to model citations data. I found that using Ruby's Hash class would be easy enough -- it allows for flexibility, while still keeping around the features that MongoMapper provides.
 
I also began design work. I posted a screenshot of what I have for the home page so far, and I've recieved good feedback. I think I'll continue designing before I get to the actual programming. This is beneficial because I don't need to write the same code twice.
 
I interviewed Josh from Fanzter, and he brought up many points I hadn't thought of. For example, keeping user data separate and secure, how to sell this product business-to-business, liability, marketing it as a SaaS ("Software-as-a-Service"), insurance, demonstration value, marketing, billing, and support. I also talked to Mrs. Carlson and she gave me more insight as to what librarians need from this product.
 
I've realized that most of the faculty I've talked to want a more structured system (teachers have more privileges than students, teachers have the ability to organized notecards, etc.), while students want an unstructured, do-it-yourself like system. I believe that it would be better to have everyone on the same level, teachers included. I also would like students to have the flexibility to organize how they'd like to -- often times the way a teacher organizes is not right for me.
 
I need to speed up the pace I'm iterating on this project. If I want to have a working version by March, I need to be working faster -- there are many hurdles ahead. Hopefully after this month (and college applications) are over I'll have more time.