-- https://github.com/mgoricki/presentation-apex-18-hidden-features


select * from apex_string.split('1234567890',null);

select apex_string.join(apex_t_varchar2('a','b','c'),':') from dual;

select * from apex_string.shuffle(apex_t_varchar2('One','Two','Three'));

declare
  v_arr apex_t_varchar2;
begin
  select ename
    bulk collect into v_arr
    from emp;
  
  dbms_output.put_line(apex_string.join(v_arr, ':'));
end;
/

select * from apex_string.shuffle(apex_t_varchar2('One','Two','Three'));

select apex_util.get_hash(
        p_values => apex_t_varchar2 (empno, sal, comm),
        p_salted => true
    ) x
from emp;

select apex_string.format('Hi %1! Hope to see you at the party. It starts at %0.'
    , '18:30'
    , 'Marko'
    , p_max_length => 10) m
from dual; 


--Key value tables - PUT/GET/DELETE
declare
  v_table apex_t_varchar2;
begin
  -- populate table
  for i in (select ename, sal from emp)
  loop
    -- put element into table
    apex_string.plist_put(v_table, i.ename, i.sal);
  end loop;
  
  
  -- get element from table
  dbms_output.put_line(
    apex_string.plist_get(v_table, 'JONES')
  );  
end;  
/

-- Email Template
declare
  v_placeholders clob;
begin
  apex_util.set_workspace('APXAPP');
  apex_json.initialize_clob_output;
  apex_json.open_object;

  apex_json.write('EVENT_NAME'     , 'MakeIT 2019');
  apex_json.write('EVENT_DATE'     , '15.10.2018.');
  apex_json.write('EVENT_LINK'     , 'N/A');
  apex_json.write('DURATION'       , '2 days');
  apex_json.write('INVITEE'        , 'Saroj Raut');
  apex_json.write('ORGANIZER'      , 'ME');
  apex_json.write('LOCATION'       , 'UK');
  apex_json.write('MY_APPLICATION_LINK', 'Test');
  apex_json.write('NOTES'         , 'n/a');
  apex_json.write('URL_LINK'      , 'n/a');
  apex_json.write('URL_NAME'      , 'n/a');
  apex_json.write('START_TIME'    , '15.10.2018.');
  
  apex_json.close_object;
  v_placeholders := apex_json.get_clob_output;
  apex_json.free_output;  
  
  -- Create the email template first
  apex_mail.send (
      p_template_static_id => 'EVENT'
    , p_placeholders       => v_placeholders
    , p_to                 => 'saroj.raut@city.ac.uk'
    );
  apex_mail.push_queue;
end;
/

-- Preparing URL
select apex_page.get_url(p_page => '17'
                        , p_items => 'P17_ITEM'
                        , p_values => '1') as my_url
from some_table;

-- OTHER PARAMETERS
-- * p_application        application id or alias. defaults to the current application.
-- * p_page               page id or alias. defaults to the current page.
-- * p_session            session id. defaults to the current session id.
-- * p_request            URL request parameter.
-- * p_debug              URL debug parameter. defaults to the current debug mode.
-- * p_clear_cache        URL clear cache parameter.
-- * p_items              comma delimited list of item names to set session state.
-- * p_values             comma separated list of item values to set session state.
-- * p_printer_friendly   URL printer friendly parameter. defaults tot he current request's printer friendly mode.
-- * p_trace              SQL trace parameter.

select * from apex_string.split('One:Two:Three', ':');
select * from apex_string.split('1234567890',null);



create or replace function random_words(
    p_word_list in apex_t_varchar2,
    p_count     in integer  default 3,   -- max 10 limit enforced
    p_delimeter in varchar2 default '-' )
    return varchar2
is
    s apex_t_varchar2;
begin
    for i in 1 .. least(p_count, 10) loop
        apex_string.push(s, p_word_list(dbms_random.value(1, p_word_list.count)));
    end loop;

    return apex_string.join(s, p_delimeter);
end;
/



set serveroutput on;

declare
    --  Borrowed from xkcd password generator which borrowed it from wherever
    xkcd_words constant apex_t_varchar2 :=
        apex_t_varchar2(
            'ability','able','aboard','about','above','accept','accident','according',
            'account','accurate','acres','across','act','action','active','activity',
            'actual','actually','add','addition','additional','adjective','adult','adventure',
            'advice','affect','afraid','after','afternoon','again','against','age',
            'ago','agree','ahead','aid','air','airplane','alike','alive',
            'all','allow','almost','alone','along','aloud','alphabet','already',
            'also','although','am','among','amount','ancient','angle','angry',
            'animal','announced','another','answer','ants','any','anybody','anyone',
            'anything','anyway','anywhere','apart','apartment','appearance','apple','applied',
            'appropriate','are','area','arm','army','around','arrange','arrangement',
            'arrive','arrow','art','article','as','aside','ask','asleep',
            'at','ate','atmosphere','atom','atomic','attached','attack','attempt',
            'attention','audience','author','automobile','available','average','avoid','aware',
            'away','baby','back','bad','badly','bag','balance','ball',
            'balloon','band','bank','bar','bare','bark','barn','base',
            'baseball','basic','basis','basket','bat','battle','be','bean',
            'bear','beat','beautiful','beauty','became','because','become','becoming',
            'bee','been','before','began','beginning','begun','behavior','behind',
            'being','believed','bell','belong','below','belt','bend','beneath',
            'bent','beside','best','bet','better','between','beyond','bicycle',
            'bigger','biggest','bill','birds','birth','birthday','bit','bite',
            'black','blank','blanket','blew','blind','block','blood','blow',
            'blue','board','boat','body','bone','book','border','born',
            'both','bottle','bottom','bound','bow','bowl','box','boy',
            'brain','branch','brass','brave','bread','break','breakfast','breath',
            'breathe','breathing','breeze','brick','bridge','brief','bright','bring',
            'broad','broke','broken','brother','brought','brown','brush','buffalo',
            'build','building','built','buried','burn','burst','bus','bush',
            'business','busy','but','butter','buy','by','cabin','cage',
            'cake','call','calm','came','camera','camp','can','canal',
            'cannot','cap','capital','captain','captured','car','carbon','card',
            'care','careful','carefully','carried','carry','case','cast','castle',
            'cat','catch','cattle','caught','cause','cave','cell','cent',
            'center','central','century','certain','certainly','chain','chair','chamber',
            'chance','change','changing','chapter','character','characteristic','charge','chart',
            'check','cheese','chemical','chest','chicken','chief','child','children',
            'choice','choose','chose','chosen','church','circle','circus','citizen',
            'city','class','classroom','claws','clay','clean','clear','clearly',
            'climate','climb','clock','close','closely','closer','cloth','clothes',
            'clothing','cloud','club','coach','coal','coast','coat','coffee',
            'cold','collect','college','colony','color','column','combination','combine',
            'come','comfortable','coming','command','common','community','company','compare',
            'compass','complete','completely','complex','composed','composition','compound','concerned',
            'condition','congress','connected','consider','consist','consonant','constantly','construction',
            'contain','continent','continued','contrast','control','conversation','cook','cookies',
            'cool','copper','copy','corn','corner','correct','correctly','cost',
            'cotton','could','count','country','couple','courage','course','court',
            'cover','cow','cowboy','crack','cream','create','creature','crew',
            'crop','cross','crowd','cry','cup','curious','current','curve',
            'customs','cut','cutting','daily','damage','dance','danger','dangerous',
            'dark','darkness','date','daughter','dawn','day','dead','deal',
            'dear','death','decide','declared','deep','deeply','deer','definition',
            'degree','depend','depth','describe','desert','design','desk','detail',
            'determine','develop','development','diagram','diameter','did','die','differ',
            'difference','different','difficult','difficulty','dig','dinner','direct','direction',
            'directly','dirt','dirty','disappear','discover','discovery','discuss','discussion',
            'disease','dish','distance','distant','divide','division','do','doctor',
            'does','dog','doing','doll','dollar','done','donkey','door',
            'dot','double','doubt','down','dozen','draw','drawn','dream',
            'dress','drew','dried','drink','drive','driven','driver','driving',
            'drop','dropped','drove','dry','duck','due','dug','dull',
            'during','dust','duty','each','eager','ear','earlier','early',
            'earn','earth','easier','easily','east','easy','eat','eaten',
            'edge','education','effect','effort','egg','eight','either','electric',
            'electricity','element','elephant','eleven','else','empty','end','enemy',
            'energy','engine','engineer','enjoy','enough','enter','entire','entirely',
            'environment','equal','equally','equator','equipment','escape','especially','essential',
            'establish','even','evening','event','eventually','ever','every','everybody',
            'everyone','everything','everywhere','evidence','exact','exactly','examine','example',
            'excellent','except','exchange','excited','excitement','exciting','exclaimed','exercise',
            'exist','expect','experience','experiment','explain','explanation','explore','express',
            'expression','extra','eye','face','facing','fact','factor','factory',
            'failed','fair','fairly','fall','fallen','familiar','family','famous',
            'far','farm','farmer','farther','fast','fastened','faster','fat',
            'father','favorite','fear','feathers','feature','fed','feed','feel',
            'feet','fell','fellow','felt','fence','few','fewer','field',
            'fierce','fifteen','fifth','fifty','fight','fighting','figure','fill',
            'film','final','finally','find','fine','finest','finger','finish',
            'fire','fireplace','firm','first','fish','five','fix','flag',
            'flame','flat','flew','flies','flight','floating','floor','flow',
            'flower','fly','fog','folks','follow','food','foot','football',
            'for','force','foreign','forest','forget','forgot','forgotten','form',
            'former','fort','forth','forty','forward','fought','found','four',
            'fourth','fox','frame','free','freedom','frequently','fresh','friend',
            'friendly','frighten','frog','from','front','frozen','fruit','fuel',
            'full','fully','fun','function','funny','fur','furniture','further',
            'future','gain','game','garage','garden','gas','gasoline','gate',
            'gather','gave','general','generally','gentle','gently','get','getting',
            'giant','gift','girl','give','given','giving','glad','glass',
            'globe','go','goes','gold','golden','gone','good','goose',
            'got','government','grabbed','grade','gradually','grain','grandfather','grandmother',
            'graph','grass','gravity','gray','great','greater','greatest','greatly',
            'green','grew','ground','group','grow','grown','growth','guard',
            'guess','guide','gulf','gun','habit','had','hair','half',
            'halfway','hall','hand','handle','handsome','hang','happen','happened',
            'happily','happy','harbor','hard','harder','hardly','has','hat',
            'have','having','hay','he','headed','heading','health','heard',
            'hearing','heart','heat','heavy','height','held','hello','help',
            'helpful','her','herd','here','herself','hidden','hide','high',
            'higher','highest','highway','hill','him','himself','his','history',
            'hit','hold','hole','hollow','home','honor','hope','horn',
            'horse','hospital','hot','hour','house','how','however','huge',
            'human','hundred','hung','hungry','hunt','hunter','hurried','hurry',
            'hurt','husband','ice','idea','identity','if','ill','image',
            'imagine','immediately','importance','important','impossible','improve','in','inch',
            'include','including','income','increase','indeed','independent','indicate','individual',
            'industrial','industry','influence','information','inside','instance','instant','instead',
            'instrument','interest','interior','into','introduced','invented','involved','iron',
            'is','island','it','its','itself','jack','jar','jet',
            'job','join','joined','journey','joy','judge','jump','jungle',
            'just','keep','kept','key','kids','kill','kind','kitchen',
            'knew','knife','know','knowledge','known','label','labor','lack',
            'lady','laid','lake','lamp','land','language','large','larger',
            'largest','last','late','later','laugh','law','lay','layers',
            'lead','leader','leaf','learn','least','leather','leave','leaving',
            'led','left','leg','length','lesson','let','letter','level',
            'library','lie','life','lift','light','like','likely','limited',
            'line','lion','lips','liquid','list','listen','little','live',
            'living','load','local','locate','location','log','lonely','long',
            'longer','look','loose','lose','loss','lost','lot','loud',
            'love','lovely','low','lower','luck','lucky','lunch','lungs',
            'lying','machine','machinery','mad','made','magic','magnet','mail',
            'main','mainly','major','make','making','man','managed','manner',
            'manufacturing','many','map','mark','market','married','mass','massage',
            'master','material','mathematics','matter','may','maybe','me','meal',
            'mean','means','meant','measure','meat','medicine','meet','melted',
            'member','memory','men','mental','merely','met','metal','method',
            'mice','middle','might','mighty','mile','military','milk','mill',
            'mind','mine','minerals','minute','mirror','missing','mission','mistake',
            'mix','mixture','model','modern','molecular','moment','money','monkey',
            'month','mood','moon','more','morning','most','mostly','mother',
            'motion','motor','mountain','mouse','mouth','move','movement','movie',
            'moving','mud','muscle','music','musical','must','my','myself',
            'mysterious','nails','name','nation','national','native','natural','naturally',
            'nature','near','nearby','nearer','nearest','nearly','necessary','neck',
            'needed','needle','needs','negative','neighbor','neighborhood','nervous','nest',
            'never','new','news','newspaper','next','nice','night','nine',
            'no','nobody','nodded','noise','none','noon','nor','north',
            'nose','not','note','noted','nothing','notice','noun','now',
            'number','numeral','nuts','object','observe','obtain','occasionally','occur',
            'ocean','of','off','offer','office','officer','official','oil',
            'old','older','oldest','on','once','one','only','onto',
            'open','operation','opinion','opportunity','opposite','or','orange','orbit',
            'order','ordinary','organization','organized','origin','original','other','ought',
            'our','ourselves','out','outer','outline','outside','over','own',
            'owner','oxygen','pack','package','page','paid','pain','paint',
            'pair','palace','pale','pan','paper','paragraph','parallel','parent',
            'park','part','particles','particular','particularly','partly','parts','party',
            'pass','passage','past','path','pattern','pay','peace','pen',
            'pencil','people','per','percent','perfect','perfectly','perhaps','period',
            'person','personal','pet','phrase','physical','piano','pick','picture',
            'pictured','pie','piece','pig','pile','pilot','pine','pink',
            'pipe','pitch','place','plain','plan','plane','planet','planned',
            'planning','plant','plastic','plate','plates','play','pleasant','please',
            'pleasure','plenty','plural','plus','pocket','poem','poet','poetry',
            'point','pole','police','policeman','political','pond','pony','pool',
            'poor','popular','population','porch','port','position','positive','possible',
            'possibly','post','pot','potatoes','pound','pour','powder','power',
            'powerful','practical','practice','prepare','present','president','press','pressure',
            'pretty','prevent','previous','price','pride','primitive','principal','principle',
            'printed','private','prize','probably','problem','process','produce','product',
            'production','program','progress','promised','proper','properly','property','protection',
            'proud','prove','provide','public','pull','pupil','pure','purple',
            'purpose','push','put','putting','quarter','queen','question','quick',
            'quickly','quiet','quietly','quite','rabbit','race','radio','railroad',
            'rain','raise','ran','ranch','range','rapidly','rate','rather',
            'raw','rays','reach','read','reader','ready','real','realize',
            'rear','reason','recall','receive','recent','recently','recognize','record',
            'red','refer','refused','region','regular','related','relationship','religious',
            'remain','remarkable','remember','remove','repeat','replace','replied','report',
            'represent','require','research','respect','rest','result','return','review',
            'rhyme','rhythm','rice','rich','ride','riding','right','ring',
            'rise','rising','river','road','roar','rock','rocket','rocky',
            'rod','roll','roof','room','root','rope','rose','rough',
            'round','route','row','rubbed','rubber','rule','ruler','run',
            'running','rush','sad','saddle','safe','safety','said','sail',
            'sale','salmon','salt','same','sand','sang','sat','satellites',
            'satisfied','save','saved','saw','say','scale','scared','scene',
            'school','science','scientific','scientist','score','screen','sea','search',
            'season','seat','second','secret','section','see','seed','seeing',
            'seems','seen','seldom','select','selection','sell','send','sense',
            'sent','sentence','separate','series','serious','serve','service','sets',
            'setting','settle','settlers','seven','several','shade','shadow','shake',
            'shaking','shall','shallow','shape','share','sharp','she','sheep',
            'sheet','shelf','shells','shelter','shine','shinning','ship','shirt',
            'shoe','shoot','shop','shore','short','shorter','shot','should',
            'shoulder','shout','show','shown','shut','sick','sides','sight',
            'sign','signal','silence','silent','silk','silly','silver','similar',
            'simple','simplest','simply','since','sing','single','sink','sister',
            'sit','sitting','situation','six','size','skill','skin','sky',
            'slabs','slave','sleep','slept','slide','slight','slightly','slip',
            'slipped','slope','slow','slowly','small','smaller','smallest','smell',
            'smile','smoke','smooth','snake','snow','so','soap','social',
            'society','soft','softly','soil','solar','sold','soldier','solid',
            'solution','solve','some','somebody','somehow','someone','something','sometime',
            'somewhere','son','song','soon','sort','sound','source','south',
            'southern','space','speak','special','species','specific','speech','speed',
            'spell','spend','spent','spider','spin','spirit','spite','split',
            'spoken','sport','spread','spring','square','stage','stairs','stand',
            'standard','star','stared','start','state','statement','station','stay',
            'steady','steam','steel','steep','stems','step','stepped','stick',
            'stiff','still','stock','stomach','stone','stood','stop','stopped',
            'store','storm','story','stove','straight','strange','stranger','straw',
            'stream','street','strength','stretch','strike','string','strip','strong',
            'stronger','struck','structure','struggle','stuck','student','studied','studying',
            'subject','substance','success','successful','such','sudden','suddenly','sugar',
            'suggest','suit','sum','summer','sun','sunlight','supper','supply',
            'support','suppose','sure','surface','surprise','surrounded','swam','sweet',
            'swept','swim','swimming','swing','swung','syllable','symbol','system',
            'table','tail','take','taken','tales','talk','tall','tank',
            'tape','task','taste','taught','tax','tea','teach','teacher',
            'team','tears','teeth','telephone','television','tell','temperature','ten',
            'tent','term','terrible','test','than','thank','that','thee',
            'them','themselves','then','theory','there','therefore','these','they',
            'thick','thin','thing','think','third','thirty','this','those',
            'thou','though','thought','thousand','thread','three','threw','throat',
            'through','throughout','throw','thrown','thumb','thus','thy','tide',
            'tie','tight','tightly','till','time','tin','tiny','tip',
            'tired','title','to','tobacco','today','together','told','tomorrow',
            'tone','tongue','tonight','too','took','tool','top','topic',
            'torn','total','touch','toward','tower','town','toy','trace',
            'track','trade','traffic','trail','train','transportation','trap','travel',
            'treated','tree','triangle','tribe','trick','tried','trip','troops',
            'tropical','trouble','truck','trunk','truth','try','tube','tune',
            'turn','twelve','twenty','twice','two','type','typical','uncle',
            'under','underline','understanding','unhappy','union','unit','universe','unknown',
            'unless','until','unusual','up','upon','upper','upward','us',
            'use','useful','using','usual','usually','valley','valuable','value',
            'vapor','variety','various','vast','vegetable','verb','vertical','very',
            'vessels','victory','view','village','visit','visitor','voice','volume',
            'vote','vowel','voyage','wagon','wait','walk','wall','want',
            'war','warm','warn','was','wash','waste','watch','water',
            'wave','way','we','weak','wealth','wear','weather','week',
            'weigh','weight','welcome','well','went','were','west','western',
            'wet','whale','what','whatever','wheat','wheel','when','whenever',
            'where','wherever','whether','which','while','whispered','whistle','white',
            'who','whole','whom','whose','why','wide','widely','wife',
            'wild','will','willing','win','wind','window','wing','winter',
            'wire','wise','wish','with','within','without','wolf','women',
            'won','wonder','wonderful','wood','wooden','wool','word','wore',
            'work','worker','world','worried','worry','worse','worth','would',
            'wrapped','write','writer','writing','written','wrong','wrote','yard',
            'year','yellow','yes','yesterday','yet','you','young','younger',
            'your','yourself','youth','zero','zoo' );
begin
    for i in 1 .. 10 loop
        dbms_output.put_line(random_words(xkcd_words));
    end loop;
end;
/

---- Randomising a word

-- Randomising a given word
with word as(
    select 'TEMPLATE' as val
    from dual
),
shuffled as(
select substr(val,rownum,1) letter
from word
connect by rownum <= length(val)
order by dbms_random.value(1,length(val))
)
select listagg(letter) 
from shuffled;

--
-- Using apex_string
--
with word as(
    select 'TEMPLATE' as val
    from dual
),
letters as(
select
    column_value,
    dbms_random.value(1,length(val)) random
from word,
    apex_string.split(val, null)
),
shuffled as(
select column_value
from letters order by random
)
select * from shuffled;

set serveroutput on;
declare
    type aa_type_int is table of NUMBER index by BINARY_INTEGER;
    aa_int  aa_type_int;
    idx  number;
begin
    loop
        idx := round(dbms_random.value(1,1000));
        aa_int(idx) := aa_int.count+1;
        dbms_output.put_line('Idx='||rpad(idx,5)||'Val='||aa_int(idx));
        exit when aa_int.count >= 10;
    end loop;
end;
/

---- Quiz Database 

primary - 5 to 11
secondary - 11 to 16
KS1  YR1 AND YR2 5-7
KS2  YR3 YR4 YR5 YR6 8-11
KS3  YR7 YR8 YR 9 12-14
kS4  YR10 YR11 15-16
kS5  YR12 YR13 17-18

Question can have multiple tags.

question_hier
question

Primary Education ->> 5-11; KS1 5 to 7, KS2 7 to 11 : KS1 = YR-1 to YR-2. KS2 = YR3 to YR-6
Secondary Education ->> 11-16; KS3 11 to 14 and KS4 14 to 16 : KS3 = YR-7 to YR-9, KS4=YR-10 to YR-11
KS5 16 to 18 is post-16 education or sixth form, more intense form of education in Math and Physics

University offers place based on A level sscores 
Normally, students take 3-4 A Levels in their first year of sixth form, and most cut back to 3 in their second year. This is because university offers are normally based on 3 A Levels.

Key Stage 1 - Foundation year and Years 1 to 2 - for pupils aged between 5 and 7 years old
Key Stage 2 - Years 3 to 6 - for pupils aged between 8 and 11 years old
Key Stage 3 - Years 7 to 9 - for pupils aged between 12 and 14 years old,
Key Stage 4 - Years 10 to 11 - for pupils aged between 15 and 16 years old, and
Key Stage 5 - Years 12 to 13 - for pupils aged between 17 and 18 years old.


Rule is simple : do it in sql, else fo in plsql

