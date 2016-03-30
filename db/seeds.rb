# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
			{name: 'Richard Hendricks', email: 'richard@example.com'},
			{name: 'Erlich Bachman', email: 'erlich@example.com'},
			{name: 'Bertram Gilfoyle', email: 'gilfoyle@example.com'},
			{name: 'Dinesh Chugtai', email: 'dinesh@example.com'},
			{name: 'Donald "Jared" Dunn', email: 'jared@example.com'},
			{name: 'Monica Hall', email: 'monica@example.com'},
			{name: 'Matthew Soh', email: 'msohcw@gmail.com'},
		]

users.each do |user|
	User.create!(	name: user[:name],
					email: user[:email],
					password: 'password',
					password_confirmation: 'password',
					confirmed_at: Time.now
				)
end

Project.create!([
	{
		user_id: 1,
		name: 'Minimum Viable Product', 
		description: "Virality vesting period technology focus mass market partner network. Partnership scrum project niche market business-to-business ecosystem series A financing strategy buyer facebook business model canvas. Influencer virality startup creative equity crowdsource branding buyer pitch first mover advantage responsive web design supply chain business-to-consumer. User experience monetization beta pitch scrum project network effects validation growth hacking holy grail equity founders bootstrapping. Lean startup gamification virality social proof direct mailing holy grail metrics. Creative gen-z influencer social media infographic.\n\nMarketing learning curve customer equity crowdsource vesting period release facebook handshake early adopters. Alpha influencer partnership startup. Niche market research & development iPad market backing metrics virality venture ramen channels business model canvas gen-z. Crowdsource buyer traction validation scrum project. Infographic iteration seed money responsive web design learning curve. Entrepreneur ownership rockstar lean startup.\n\nBeta gamification deployment. Growth hacking infographic branding accelerator research & development leverage android sales stock twitter beta. Direct mailing equity pivot user experience angel investor innovator metrics client buyer conversion. IPad business model canvas leverage infrastructure facebook rockstar supply chain non-disclosure agreement first mover advantage ownership influencer. Prototype long tail direct mailing social media burn rate return on investment funding responsive web design backing supply chain termsheet. Gen-z startup social media conversion venture product management android return on investment business plan stock disruptive customer.",
		target: 10000,
		expires: 10.minutes.from_now

	},
	{
		user_id: 2,
		name: 'The Cap Table', 
		description: "Network effects research & development funding product management long tail partner network founders. Research & development vesting period venture business-to-business entrepreneur startup crowdsource. Seed money funding analytics pivot interaction design bootstrapping. Technology branding seed round. Holy grail graphical user interface conversion facebook low hanging fruit responsive web design lean startup disruptive iteration channels ramen focus strategy customer. Beta backing alpha first mover advantage gen-z ecosystem creative direct mailing series A financing marketing rockstar value proposition.\n\nEarly adopters mass market creative infrastructure user experience responsive web design entrepreneur startup gen-z. Traction venture seed money paradigm shift twitter lean startup crowdsource monetization angel investor creative interaction design. Investor technology non-disclosure agreement gen-z. Sales traction influencer. Series A financing research & development stock release direct mailing iteration facebook analytics influencer first mover advantage traction growth hacking gamification stealth. Pitch interaction design venture return on investment accelerator growth hacking niche market value proposition crowdfunding vesting period.\n\nOwnership pivot alpha product management stock buzz disruptive. Rockstar buzz MVP lean startup marketing ramen low hanging fruit partnership startup supply chain launch party iPhone termsheet business model canvas. Research & development channels scrum project deployment success pivot business-to-business. Growth hacking pivot analytics social proof leverage customer. Venture customer holy grail analytics direct mailing infographic. Strategy influencer equity product management analytics low hanging fruit innovator holy grail android channels client pitch paradigm shift.",
		target: 20000,
		expires: 1.hour.from_now
	},
	{
		user_id: 3,
		name: 'Articles of Incorporation', 
		description: "Beta growth hacking marketing channels strategy iPad success. Niche market hypotheses termsheet customer rockstar pitch metrics business model canvas learning curve crowdsource equity MVP series A financing. Mass market accelerator vesting period ramen user experience market seed round startup research & development network effects social media advisor crowdsource. Series A financing non-disclosure agreement long tail bootstrapping termsheet hackathon market return on investment angel investor branding freemium. Buyer business model canvas graphical user interface handshake infographic partner network. Holy grail business-to-consumer user experience crowdfunding success buyer conversion founders early adopters stock innovator monetization business plan sales.\n\nPrototype gamification success bootstrapping investor influencer strategy churn rate validation android. Niche market crowdsource supply chain. Seed money marketing conversion traction bootstrapping growth hacking channels stealth social media. Paradigm shift partnership MVP low hanging fruit market virality growth hacking assets venture burn rate business plan. Rockstar ramen assets early adopters advisor. Freemium value proposition pitch.\n\nStartup freemium equity channels venture conversion twitter iPad infrastructure interaction design. Influencer business model canvas early adopters strategy facebook. Branding twitter strategy termsheet social proof business-to-consumer venture. Mass market analytics facebook return on investment. Validation series A financing accelerator scrum project. Startup ramen traction paradigm shift investor user experience partnership iPad release virality.",
		target: 40000,
		expires: 1.day.from_now
	},
	{
		user_id: 4,
		name: 'Fiduciary Duties', 
		description: "Seed money niche market social proof responsive web design learning curve vesting period gen-z iPad success facebook ecosystem. Business-to-consumer strategy android low hanging fruit advisor long tail gamification. Customer business-to-consumer virality iteration freemium social media MVP product management lean startup disruptive. Product management success return on investment gen-z traction assets non-disclosure agreement angel investor network effects mass market user experience. Responsive web design growth hacking rockstar angel investor business-to-business hypotheses ramen influencer startup graphical user interface innovator business plan series A financing mass market. Accelerator founders social media direct mailing iPhone.\n\nA/B testing learning curve entrepreneur release. Funding assets disruptive backing accelerator business plan long tail research & development gen-z scrum project sales market customer. Pitch twitter technology social proof analytics ecosystem supply chain success responsive web design mass market launch party bootstrapping sales. Return on investment client android low hanging fruit hypotheses virality value proposition churn rate. Facebook rockstar stealth metrics partnership equity iteration lean startup churn rate virality long tail hackathon. Branding gen-z bandwidth facebook release holy grail traction startup rockstar founders angel investor network effects.\n\nAgile development metrics hypotheses research & development venture creative vesting period network effects. Infographic value proposition pitch twitter alpha first mover advantage startup ownership seed money scrum project. Funding buzz infrastructure growth hacking non-disclosure agreement. Business-to-business social media focus bandwidth twitter lean startup stealth traction long tail venture termsheet vesting period network effects A/B testing. Low hanging fruit virality lean startup seed round launch party technology vesting period growth hacking first mover advantage investor venture. Android holy grail client pitch business plan freemium iPhone market validation vesting period buzz ownership disruptive accelerator.",
		target: 50000,
		expires: 15.days.from_now
	},
	{
		user_id: 5,
		name: 'Signalling Risk', 
		description: "Customer venture mass market metrics. Non-disclosure agreement iPad backing android facebook freemium bootstrapping business-to-consumer stock. Branding entrepreneur social proof business plan infrastructure backing buzz agile development business model canvas analytics. Founders research & development venture series A financing conversion scrum project ramen A/B testing infrastructure handshake termsheet virality non-disclosure agreement. Early adopters iteration gen-z stock backing research & development first mover advantage pivot learning curve founders user experience. Conversion research & development bootstrapping success social proof.\n\nTwitter strategy scrum project holy grail user experience direct mailing android sales startup ecosystem iPhone hackathon entrepreneur. Agile development user experience burn rate. Ownership rockstar holy grail partner network churn rate beta innovator graphical user interface deployment. Long tail lean startup virality value proposition android mass market paradigm shift. Mass market research & development channels early adopters learning curve pivot gamification focus hypotheses supply chain technology return on investment. Twitter learning curve facebook accelerator infrastructure client supply chain.\n\nHackathon business model canvas business-to-consumer. Freemium long tail angel investor traction iteration mass market responsive web design innovator. Hypotheses influencer buzz learning curve sales long tail vesting period prototype series A financing stock. Crowdsource traction business-to-business release hypotheses advisor. Ramen accelerator validation startup interaction design success leverage infographic release mass market venture crowdsource disruptive freemium. Freemium burn rate analytics interaction design learning curve conversion low hanging fruit infographic bootstrapping buzz crowdsource.",
		target: 80000,
		expires: 1.month.from_now
	},
	{
		user_id: 6,
		name: 'Third Party Insourcing', 
		description: "Influencer stock angel investor niche market business model canvas supply chain advisor scrum project seed money. IPad interaction design traction. Lean startup return on investment network effects handshake interaction design hackathon early adopters graphical user interface beta disruptive value proposition investor. First mover advantage non-disclosure agreement gen-z deployment infrastructure ramen launch party. Advisor bandwidth infographic. Early adopters focus seed money success MVP partnership supply chain learning curve bandwidth ecosystem lean startup.\n\nLean startup social media entrepreneur stealth agile development deployment pivot gen-z. Freemium MVP social proof low hanging fruit influencer entrepreneur funding. Twitter leverage sales release focus analytics venture growth hacking long tail buyer. Business-to-consumer early adopters client. Bootstrapping interaction design pitch founders early adopters non-disclosure agreement bandwidth. Launch party disruptive client first mover advantage niche market responsive web design research & development prototype backing startup crowdsource.\n\nEquity social media channels. Buzz value proposition creative long tail. Research & development early adopters assets crowdsource direct mailing business-to-consumer niche market startup android business model canvas branding backing. Founders conversion churn rate burn rate early adopters influencer. Hackathon technology business-to-business growth hacking gamification niche market seed round investor release assets success marketing A/B testing. Responsive web design beta infrastructure low hanging fruit growth hacking business-to-business.",
		target: 100000,
		expires: 1.month.from_now
	},
]
)