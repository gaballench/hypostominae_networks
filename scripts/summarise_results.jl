using PhyloNetworks
using Gadfly
using PhyloPlots
using CSV
using DataFrames
using RCall

net0 = readSnaqNetwork("snaq_hypostominae_h0.out")
rootatnode!(net0, "panaque_cochliodon19170")
plot(net0, :R);

net1 = readSnaqNetwork("snaq_hypostominae_h1.out")
rootatnode!(net1, "panaque_cochliodon19170")
plot(net1, :R, showGamma = true);

h1_scores = [3428.6023749374035,
5248.25701466606,
24486.481976455416,
31562.395580997378,
68489.56075921377,
80420.39567803104,
83534.43096267508,
95728.72497923285,
111983.16900046023]
plot(x=collect(1:9), y=h1_scores, Geom.point, Geom.line)

h1_nt2 = readTopology("(((((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6723526614965697,(((hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8906677973294852,(((((hypostomus_cf_gymnorhynchus80910,hypostomus_sp55539):0.7816926911349446,hemiancistrus_cerrado66643):0.004900393439379652,hypostomus_melanephelis54012):0.04582046703527931,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.5084865423534195):0.12664808443325457,((hypostomus_cfhemicochliodon64160,hypostomus_sp50059):0.29410365129810184,hypostomus_faveolus27640):0.29233065177194273):0.14775899219868457):0.4192043783297875)#H28:0.11431378477936034::0.964746752246218):0.20333647087570433,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.2173914819641287,panaque_cochliodon19170):0.6460025624044361):0.2552592754454844,spectracanthicus_immaculatus43225):0.23615331499109457,(scobinancistrus_aureatus61467,((peckoltia_snethlageae57059,(((panaqolus_sp61753,panaqolus_gnomus57729):0.22936954349384697,panaqolus_sp57507):0.254069013518344,(peckoltia_compta61756,peckoltia_braueri69540):0.4389386919383329):0.06779285464070509):0.04631066228916413,(hypancistrus_sp61759,(#H28:0.9006318821008312::0.035253247753782024,micracanthicus_vandragti54408):0.28708367278343616):0.2768315958468627):0.2709374804143659):0.7072087268456121,aphanotorulus_emarginatus19719);")
plot(h1_nt2, :R, showGamma = true);

#hardwiredClusterDistance(net1, h1_nt2, false)

net2 = readSnaqNetwork("snaq_hypostominae_h2.out")
rootatnode!(net2, "panaque_cochliodon19170")
R"pdf('net2_best.pdf', width=25, height=20)"
PhyloPlots.plot(net2, :R, showGamma = true);
R"dev.off()"

### process the best nets from each run as output for dendroscope
# copy and paste the output of this thing into a text file
map(x -> println(writeTopology(x, di=true)), readMultiTopology("h2_bestruns.txt"))
# once opening the nets into dendroscope they can be modified at once for dimensions and also
# the hardwired cluster distance calculated.
# the distance matrix was writen to a text file and loaded with R for plotting the hclust:
#R> distance = as.matrix(read.table("h2_bestruns_hardwired.txt", sep=" "))
#R> plot(hclust(as.dist(distance)))
#did the same as above but for the .networks file

net2_svg = SVG("net2.svg", 6inch, 4inch)
draw(net2_svg, net2_plot)

h2_scores = [3039.6293207579847,
3496.941591321892,
3572.5010254196086,
4799.277950376557,
7727.609750219494,
19411.673746933215,
26381.975741120223,
32861.2096058347,
51096.10838544357,
52606.327682086034,
69796.86956435142,
107606.21665015492]

# first four nets are really alike in loglik
h2_perturb_scores = Gadfly.plot(x=collect(1:12), y=h2_scores, Geom.point, Geom.line)
net2_perturb_svg = SVG("net2_perturb_scores.svg", 6inch, 4inch)
draw(net2_perturb_svg, h2_perturb_scores)

### pseudodeviances of the 20 best run nets
h2_bestruns_scores = [3039.6293207579847,
3067.1562582294414,
3116.5885201956266,
3227.598891870439,
3241.5979669802546,
3279.8713105734414,
3287.963716372608,
3409.070439663338,
3409.4170844667465,
3409.5966430123117,
3410.3516391168387,
3416.0337029364955,
3423.8951347643037,
3426.07150114547,
3426.4224246726876,
3428.044398841908,
3428.358890083955,
3428.5975851093804,
3428.792425538779,
3486.4872241956327]

h2_bestruns_scores = Gadfly.plot(x=collect(1:20), y=h2_bestruns_scores, Geom.point, Geom.line)
net2_bestruns_svg = SVG("net2_bestruns_scores.svg", 6inch, 4inch)
draw(net2_bestruns_svg, h2_bestruns_scores)


h2_nt2 = readTopology("(((((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.22055509399502385,panaque_cochliodon19170):0.6804138713937925,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6696823048541771,((((hypostomus_faveolus27640,#H29:0.3832621809047049::0.48617683145248014):0.14397617651320943,(hypostomus_cfhemicochliodon64160,hypostomus_sp50059):0.27221134005785763):0.5083329604226606,((hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8102124101853093,((((hemiancistrus_cerrado66643,(hypostomus_cf_gymnorhynchus80910,hypostomus_sp55539):0.7606092089501005):0.0062063560693928314,hypostomus_melanephelis54012):0.04490867951817678,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.4967533579489195):0.05893390207130073)#H29:0.23740560465303837::0.5138231685475199):0.19163019329534065):0.25562469934289844,#H28:::0.11179232127681192):0.09863972874822348):0.1920274396599986):0.24203112771312452,spectracanthicus_immaculatus43225):0.2278901208340702,(scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.2299127011106419,panaqolus_sp57507):0.2486130895049933,(peckoltia_compta61756,peckoltia_braueri69540):0.43122523827067755):0.06632758034723632,peckoltia_snethlageae57059):0.04515801825815686,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:::0.8882076787231881):0.2886585477365104):0.27971968164767547):0.7307837645980675,aphanotorulus_emarginatus19719);")
rootatnode!(h2_nt2, "panaque_cochliodon19170")
h2_nt3 = readTopology("(((((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.2203456378081182,panaque_cochliodon19170):0.7048984146186782,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.7134908065905552,((#H29:0.5437569068391418::0.1695989261817884,((hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8806515796758875,((((hemiancistrus_cerrado66643,(hypostomus_cf_gymnorhynchus80910,hypostomus_sp55539):0.7986661896618478):0.006184178268743256,hypostomus_melanephelis54012):0.04287681964270134,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.5087889650335179):0.05284786024898018,(hypostomus_faveolus27640,((hypostomus_cfhemicochliodon64160,hypostomus_sp50059):0.17892644228031246)#H29:0.167254639536823::0.8304010738182116):0.4009410591950979):0.1893840002772706):0.1490847335220321):0.21161081006487606,#H28:::0.11494949408602478):0.09226865028132114):0.1775909912484734):0.2377605078416279,spectracanthicus_immaculatus43225):0.2264583266404269,(scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.2301428974297253,panaqolus_sp57507):0.25154991116914266,(peckoltia_compta61756,peckoltia_braueri69540):0.4400069486268822):0.06617391111982646,peckoltia_snethlageae57059):0.04498835870527149,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:::0.8850505059139753):0.2901096848881547):0.28409597280962956):0.7245540808341406,aphanotorulus_emarginatus19719);")
rootatnode!(h2_nt3, "panaque_cochliodon19170")
h2_nt4 = readTopology("(((((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.188496114323146,panaque_cochliodon19170):0.6655795949409739,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6858084402056316,((((hypostomus_faveolus27640)#H29:::0.5724689483945345,(hypostomus_cfhemicochliodon64160,hypostomus_sp50059):0.02871874694803003):0.6081262544257813,((hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8737415674230666,((((hemiancistrus_cerrado66643,(hypostomus_cf_gymnorhynchus80910,hypostomus_sp55539):0.7786387168646663):0.0055962132688611365,hypostomus_melanephelis54012):0.029331483105645144,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.4892246580563065):0.06284377491375394,#H29:::0.42753105160546545):0.14780659051458536):0.0):0.3138060560850322,#H28:::0.10761480794994296):0.1747966213338828):0.19037580136538268):0.22533360490966428,spectracanthicus_immaculatus43225):0.22959326380580625,(scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.16605942886126496,panaqolus_sp57507):0.25711188272766006,(peckoltia_compta61756,peckoltia_braueri69540):0.4797082322612593):0.06281779785923348,peckoltia_snethlageae57059):0.04522778287958774,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:::0.8923851920500571):0.30160722604269896):0.25259100245765087):0.7286976530427923,aphanotorulus_emarginatus19719);")
rootatnode!(h2_nt4, "panaque_cochliodon19170")

plot(h2_nt2, :R, showGamma = true);
plot(h2_nt3, :R, showGamma = true);
plot(h2_nt4, :R, showGamma = true);

### loglik scores for the best nets per iteration

scores = [net0.loglik, net1.loglik, net2.loglik]
Gadfly.plot(x=collect(0:2), y=scores, Geom.point, Geom.line)

### h3

net3 = readSnaqNetwork("snaq_hypostominae_h3.out")
rootatnode!(net3, "panaque_cochliodon19170")
plot(net3, :R, showGamma = true);

h3_scores = [2972.5751973859046,
3017.4962547832215,
3102.4554507883713,
3212.761283771933,
3380.026305607086,
4574.076313206952,
5744.459227854193,
7536.089604910059,
7550.55510629836,
8076.402065611572,
17825.545810927313,
26350.856567083036,
33740.10491182391,
50605.10517568199,
51244.84132675547,
66424.62166321895,
108377.84058348568
]

# first four nets are really alike in loglik
plot(x=collect(1:length(h3_scores)), y=h3_scores, Geom.point, Geom.line)

h3_nt2 = readTopology("(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299,((((((hemiancistrus_cerrado66643,(hypostomus_sp55539,(hypostomus_cf_gymnorhynchus80910)#H30:::0.8641480399221307):0.9928033089206215):0.01738714499612035,hypostomus_melanephelis54012):0.04536608899569839,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.4989585996450088):0.01459090469176022,#H30:::0.13585196007786926):0.05797475516850964,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(#H29:0.473996111413424::0.11232397622842386,hypostomus_sp50059):0.3390090511017069):0.3468581310114571):0.36930706995560375):0.20504250641841357,((#H28:1.4556730916056386::0.11230740853877676,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6765415007234095,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.225676560479514,panaqolus_sp57507):0.2527296449550413,(peckoltia_compta61756,peckoltia_braueri69540):0.4332017136406374):0.06480364178816729,peckoltia_snethlageae57059):0.047483092989286386,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.0035345595512712::0.8876925914612233):0.2921299397178259):0.27936073928031985):0.6786796408097904,aphanotorulus_emarginatus19719):0.2287417797879543,spectracanthicus_immaculatus43225):0.2405677582333428,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.2208908641574088,panaque_cochliodon19170):0.6525602033889694):0.1918304666531259):0.09004951862302729):0.22340683037231354)#H29:0.20126244780557992::0.8876760237715762):0.8354814125250088);")
rootatnode!(h3_nt2, "panaque_cochliodon19170")
h3_nt3 = readTopology("(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299,((((((hemiancistrus_cerrado66643,#H30:::0.43531962386172596):0.0164240346771906,hypostomus_melanephelis54012):0.057681581498505365,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.4898987378228286):0.017607049318059117,(hypostomus_cf_gymnorhynchus80910,(hypostomus_sp55539)#H30:::0.564680376138274):4.194539504997145):0.06878637281635694,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(#H29:0.4529736010353506::0.1150358298764434,hypostomus_sp50059):0.3555526047153425):0.34530725168940435):0.37425447072085527):0.208540418299049,((#H28:1.6067414450733213::0.1124357272276734,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6791293387091066,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.22180349761824247,panaqolus_sp57507):0.2550640467642243,(peckoltia_compta61756,peckoltia_braueri69540):0.4325326861942007):0.06417001376750978,peckoltia_snethlageae57059):0.0470009686516887,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.1020710448398403::0.8875642727723266):0.290004313094925):0.27784865990648605):0.6861161565616817,aphanotorulus_emarginatus19719):0.22689562968934582,spectracanthicus_immaculatus43225):0.24137239766518548,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.21827175138856023,panaque_cochliodon19170):0.6543581938842332):0.1910113777070624):0.09185138450847895):0.22103993158902202)#H29:0.2042655331277781::0.8849641701235567):0.8350359468186734);")
rootatnode!(h3_nt3, "panaque_cochliodon19170")
h3_nt4 = readTopology("((hemiancistrus_cerrado66643,(hypostomus_melanephelis54012,((hypostomus_strigaticeps61230,hypostomus_sp76321):0.49595946829333204,((((#H29:::0.15210206583509017,(#H28:1.4930547369469453::0.11309249137010002,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6730391429414025,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.2190031075250554,panaqolus_sp57507):0.2571898940838226,(peckoltia_compta61756,peckoltia_braueri69540):0.4448029956532737):0.06660496044389608,peckoltia_snethlageae57059):0.043289752458564534,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.0475559200166527::0.8869075086299):0.28797383977954955):0.2781299344488604):0.6858433076716824,aphanotorulus_emarginatus19719):0.22968839767350893,spectracanthicus_immaculatus43225):0.2391985686223204,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.21965183010362,panaque_cochliodon19170):0.6607352481615312):0.1920363781869561):0.10174282627596026):0.16992836468848893):0.16925649801456094,(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.887831893501841):0.14533906341720595,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(hypostomus_sp50059)#H29:::0.8478979341649098):0.43107161708489306):0.3360498917073494):0.09649758658656403)#H30:0.02860023854250368::0.9581422645934599):0.05996858776366029):0.013798321220488012):0.8215911501020307,hypostomus_sp55539,(hypostomus_cf_gymnorhynchus80910,#H30:2.352901332720001::0.04185773540654013):0.026967422397275696);")
rootatnode!(h3_nt4, "panaque_cochliodon19170")
h3_nt5 = readTopology("(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299,((((((hemiancistrus_cerrado66643)#H30:::0.816992330664446,hypostomus_melanephelis54012):0.051963026292751915,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.5256964071326798):0.032777127440466874,(hypostomus_cf_gymnorhynchus80910,(#H30:::0.183007669335554,hypostomus_sp55539):0.02066049409101993):0.8072101032234587):0.06656463683182386,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(#H29:0.5395640460435537::0.0992648665503151,hypostomus_sp50059):0.2852214910050526):0.25697321694050507):0.36674283821671033):0.1961438236541989,((#H28:1.4886349677643496::0.09398514478563981,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6502901653074719,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.1568556450600372,panaqolus_sp57507):0.2850567400693334,(peckoltia_compta61756,peckoltia_braueri69540):0.409199677690638):0.04592737777695031,peckoltia_snethlageae57059):0.051980457821572235,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:0.7866805565319449::0.9060148552143602):0.2510939414851629):0.2608428686241547):0.6988331654571943,aphanotorulus_emarginatus19719):0.2203535520476286,spectracanthicus_immaculatus43225):0.2428330780373629,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.24999950594775971,panaque_cochliodon19170):0.6532079610351003):0.17747770286801193):0.05829591989017459):0.21564081167105473)#H29:0.24647143659656096::0.9007351334496849):0.7767289117866392);")
rootatnode!(h3_nt5, "panaque_cochliodon19170")
h3_nt6 = readTopology("((hemiancistrus_cerrado66643,(hypostomus_melanephelis54012,((hypostomus_strigaticeps61230,hypostomus_sp76321):0.49486838711243675,(((((((hypostomus_faveolus27640)#H29:::0.5349379795150838,hypostomus_cfhemicochliodon64160):0.1539898190658729,hypostomus_sp50059):0.6631723185243769,(#H28:1.5231088224552158::0.10253484944584516,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6656608074544133,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.23191231921660407,panaqolus_sp57507):0.24588504585311996,(peckoltia_compta61756,peckoltia_braueri69540):0.44041195499502117):0.06954863833181679,peckoltia_snethlageae57059):0.049583777905867134,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:0.44291261306916985::0.8974651505541549):0.2800091208497736):0.27350988196140835):0.6798468374738785,aphanotorulus_emarginatus19719):0.22831428179202176,spectracanthicus_immaculatus43225):0.23768216345740062,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.2201135238582882,panaque_cochliodon19170):0.66447253666353):0.18958142097713637):0.18707858256116827):0.30284843768961145):0.0,(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8974503419705608):0.16673504372406486,#H29:::0.4650620204849162):0.02208558927916546)#H30:0.024423974948898475::0.9452232542049559):0.05497972269981652):0.02258859224809948):0.8630946795281769,hypostomus_sp55539,(hypostomus_cf_gymnorhynchus80910,#H30:1.162755778311094::0.05477674579504415):0.02760714174487807);")
rootatnode!(h3_nt6, "panaque_cochliodon19170")
h3_nt7 = readTopology("((hemiancistrus_cerrado66643,(hypostomus_melanephelis54012,((hypostomus_strigaticeps61230,hypostomus_sp76321):0.49096471561875427,((((((hypostomus_cfhemicochliodon64160)#H29:::0.5377176819245006,hypostomus_sp50059):1.632719751581243,(#H28:0.771184169630113::0.1081652406053051,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6796930987328816,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.2282519615177095,panaqolus_sp57507):0.2506255888041859,(peckoltia_compta61756,peckoltia_braueri69540):0.43229802775815346):0.06165054179633598,peckoltia_snethlageae57059):0.04989250703528392,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.1310079817170369::0.8918347593946949):0.2917893303642325):0.2756487395230422):0.6863949688741668,aphanotorulus_emarginatus19719):0.22872993792051097,spectracanthicus_immaculatus43225):0.2378562852799112,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.20565975641383963,panaque_cochliodon19170):0.661963327360272):0.18998469444149052):0.14481910249251181):0.3445168678127681):0.0,(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8761313889560427):0.09787111119410968,(hypostomus_faveolus27640,#H29:::0.46228231807549935):0.862483641163646):0.12401380905087238)#H30:0.0::0.9404948948119786):0.06512951573723473):0.0017271184381149646):0.8767819703818869,hypostomus_sp55539,(hypostomus_cf_gymnorhynchus80910,#H30:0.7872387697275359::0.05950510518802143):0.0029397704939622222);")
rootatnode!(h3_nt7, "panaque_cochliodon19170")
h3_nt8 = readTopology("(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299,(((((hypostomus_melanephelis54012)#H30:::0.5412173747334807,(hypostomus_strigaticeps61230,hypostomus_sp76321):0.46455454538497487):0.017835843771231163,(hypostomus_cf_gymnorhynchus80910,((hemiancistrus_cerrado66643,#H30:::0.45878262526651925):0.8848963927180384,hypostomus_sp55539):0.027554752173899476):0.22565319126275088):0.06996565219835321,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(#H29:0.5465731481034434::0.10639132051951347,hypostomus_sp50059):0.40504606017070416):0.33746655076414395):0.37013332150807415):0.214521676845975,((#H28:1.4881183946749388::0.11765135504797218,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.635344478766432,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.2198328971561764,panaqolus_sp57507):0.2567973366912371,(peckoltia_compta61756,peckoltia_braueri69540):0.40610155718146795):0.061617378759954315,peckoltia_snethlageae57059):0.04761903348948628,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.0633124739415531::0.8823486449520278):0.29210265624234005):0.2753441827569507):0.6787042668432606,aphanotorulus_emarginatus19719):0.2228426339461786,spectracanthicus_immaculatus43225):0.25321499584558044,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.21298645760785462,panaque_cochliodon19170):0.6869773198780605):0.18515289205033292):0.0959311930625117):0.21359644777909406)#H29:0.19833745876253384::0.8936086794804865):0.8239521425845883);")
rootatnode!(h3_nt8, "panaque_cochliodon19170")
h3_nt9 = readTopology("(hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299,(((#H30:0.01749582618613589::0.4985499307228927,(hypostomus_cf_gymnorhynchus80910,((hemiancistrus_cerrado66643,(hypostomus_melanephelis54012,((hypostomus_strigaticeps61230,hypostomus_sp76321):0.5081313847594767)#H30:0.06059139405919146::0.5014500692771073):0.01825578356426981):0.0,hypostomus_sp55539):0.021986094980885863):0.16840515861840877):0.043150384404809804,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,(#H29:0.48240960395582594::0.10302344085667232,hypostomus_sp50059):0.3428219199030196):0.3988022383198589):0.3385762435389358):0.18842093893989167,((#H28:1.3876725153002656::0.10779173505800854,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6967036154654846,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.21816041738769032,panaqolus_sp57507):0.25485359411356895,(peckoltia_compta61756,peckoltia_braueri69540):0.43820791456368974):0.06542282796408393,peckoltia_snethlageae57059):0.04223607958566272,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:0.9713350828065476::0.8922082649419915):0.29161322149966395):0.2892118183393198):0.7117551622348839,aphanotorulus_emarginatus19719):0.2253159863837381,spectracanthicus_immaculatus43225):0.24041685671768825,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.23039881830295628,panaque_cochliodon19170):0.65574108501295):0.19952604838224214):0.07101107660393703):0.2134129304154619)#H29:0.17752116474182691::0.8969765591433276):0.8715165006668261);")
rootatnode!(h3_nt9, "panaque_cochliodon19170")
h3_nt10 = readTopology("((hemiancistrus_cerrado66643,(hypostomus_melanephelis54012,((hypostomus_strigaticeps61230,hypostomus_sp76321):0.47761347014036254,((#H29:0.3489057722339627::0.3420397758162643,(hypostomus_faveolus27640,(hypostomus_cfhemicochliodon64160,((((hemiancistrus_punctulatus60931,hemiancistrus_fuliginosus61299):0.8368455233563383)#H29:0.22143108908754924::0.6579602241837357,(#H28:1.0064008610756758::0.11476422946572457,((pterygoplichthys_multiradiatus47289,pterygoplichthys_anisitsi26686):0.6736307360658732,((((scobinancistrus_aureatus61467,(((((panaqolus_sp61753,panaqolus_gnomus57729):0.24984792688405338,panaqolus_sp57507):0.2521670231403177,(peckoltia_compta61756,peckoltia_braueri69540):0.4494271226915479):0.08426764656697783,peckoltia_snethlageae57059):0.019383375757265092,(hypancistrus_sp61759,(micracanthicus_vandragti54408)#H28:1.1997644744893203::0.8852357705342755):0.3195132439151738):0.28174307753555367):0.6867354660563799,aphanotorulus_emarginatus19719):0.2369454864735877,spectracanthicus_immaculatus43225):0.23254436009918952,((spectracanthicus_murinus57231,baryancistrus_beggini39227):0.21423933363078626,panaque_cochliodon19170):0.6578524957626406):0.194985672214046):0.1717783699759393):0.13554251068697065):0.294646846462711,hypostomus_sp50059):0.0):0.0):0.1387850033207757):0.0)#H30:0.02503841714154885::0.9341746187609901):0.051755379825764454):0.014944314534736892):0.8916745113826147,hypostomus_sp55539,(hypostomus_cf_gymnorhynchus80910,#H30:1.6835775786481009::0.06582538123901):0.03157610677245271);")
rootatnode!(h3_nt10, "panaque_cochliodon19170")

plot(h3_nt2, :R, showGamma = true);
plot(h3_nt3, :R, showGamma = true);
plot(h3_nt4, :R, showGamma = true);
plot(h3_nt5, :R, showGamma = true);
plot(h3_nt6, :R, showGamma = true);
plot(h3_nt7, :R, showGamma = true);
plot(h3_nt8, :R, showGamma = true);
plot(h3_nt9, :R, showGamma = true);
plot(h3_nt10, :R, showGamma = true);


### loglik scores for the best nets per iteration

scores = [net0.loglik, net1.loglik, net2.loglik, net3.loglik]
scores_plot = Gadfly.plot(x=collect(0:3), y=scores, Geom.point, Geom.line,
                          Guide.xlabel("h"), Guide.ylabel("Pseudo-deviance"))

scores_svg = SVG("scores.svg", 6inch, 4inch)
draw(scores_svg, scores_plot)



### TICR test for h=1

CFtable = readTableCF("../CFs_75p.csv") # read observed quartet CF
topologyQPseudolik!(net0, CFtable)         # update the fitted CFs under net0
fitCF0 = fittedQuartetCF(CFtable, :long)    # extract them to a data frame
topologyQPseudolik!(net1, CFtable)         # update the fitted CFs under net1
fitCF1 = fittedQuartetCF(CFtable, :long)    # extract them to a data frame

fitCF = rename(fitCF0, :expCF => :expCF_net0); # rename column "expCF" to "expCF_net0"
fitCF[:,:expCF_net1] = fitCF1[:,:expCF];         # add new column "expCF_net1"
CSV.write("fittedCF_h0_h1.csv", fitCF)        # export to .csv file

#fitCF0[:h] = 0
fitCF0[:, :h] = zeros(Int64, size(fitCF0, 1))
#fitCF1[:h] = 1
fitCF1[:, :h] = ones(Int64, size(fitCF1, 1))
fitCF = vcat(fitCF0, fitCF1)

@rlibrary ggplot2
ggplot(fitCF, aes(x=:obsCF, y=:expCF)) + geom_point(alpha=0.1) +
  xlab("CF observed in gene trees") + ylab("CF expected under tree (h=0) or network (h=1)") +
  facet_grid(R"~h", labeller = label_both)

### TICR test for h=2

CFtable = readTableCF("../CFs_75p.csv") # read observed quartet CF
topologyQPseudolik!(net0, CFtable)         # update the fitted CFs under net0
fitCF0 = fittedQuartetCF(CFtable, :long)    # extract them to a data frame
topologyQPseudolik!(net2, CFtable)         # update the fitted CFs under net2
fitCF2 = fittedQuartetCF(CFtable, :long)    # extract them to a data frame

fitCF = rename(fitCF0, :expCF => :expCF_net0); # rename column "expCF" to "expCF_net0"
fitCF[:,:expCF_net2] = fitCF2[:,:expCF];         # add new column "expCF_net1"
CSV.write("fittedCF_h0_h2.csv", fitCF)        # export to .csv file

#fitCF0[:h] = 0
fitCF0[:, :h] = zeros(Int64, size(fitCF0, 1))
#fitCF1[:h] = 1
fitCF2[:, :h] = ones(Int64, size(fitCF2, 1)) .+ 1
fitCF = vcat(fitCF0, fitCF2)

@rlibrary ggplot2
p = ggplot(fitCF, aes(x=:obsCF, y=:expCF)) + geom_point(alpha=0.1) +
  xlab("CF observed in gene trees") + ylab("CF expected under tree (h=0) or network (h=2)") +
  facet_grid(R"~h", labeller = label_both)
@rput p

R"library(ggplot2); ggsave('ticr.pdf', p)"
