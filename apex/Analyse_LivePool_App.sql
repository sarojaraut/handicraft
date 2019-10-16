declare
    c               integer := 0;
    l_respondent_id number;
    l_v01           varchar2(4000);
    l_v02           varchar2(4000);
    l_v03           varchar2(4000);
    l_v04           varchar2(4000);
    l_v05           varchar2(4000);
    l_v06           varchar2(4000);
    l_v07           varchar2(4000);
    l_v08           varchar2(4000);
    l_v09           varchar2(4000);
    l_v10           varchar2(4000);
    l_v11           varchar2(4000);
    l_v12           varchar2(4000);
    l_mand          varchar2(1) := 'N';
    g_cnt           integer := 0;
    l_use_sections_yn   varchar2(1);
    l_section_id        number;
    l_max_question_seq  number;
    l_vc_arr2       APEX_APPLICATION_GLOBAL.VC_ARR2;


    procedure display_checkbox (
       p_id       in number, 
       p_answer   in varchar2 default null, 
       p_value_01 in varchar2 default null,
       p_value_02 in varchar2 default null,
       p_value_03 in varchar2 default null,
       p_value_04 in varchar2 default null,
       p_value_05 in varchar2 default null,
       p_value_06 in varchar2 default null,
       p_value_07 in varchar2 default null,
       p_value_08 in varchar2 default null,
       p_value_09 in varchar2 default null,
       p_value_10 in varchar2 default null,
       p_value_11 in varchar2 default null,
       p_value_12 in varchar2 default null
       )
    is 
        l_id varchar2(30);
    begin
        g_cnt := g_cnt + 1;
        l_id := 'Q'||to_char((p_id * 20) + g_cnt);
        if p_answer is not null then
            sys.htp.p('<div class="lp-Question-inputCheckbox">');
            sys.htp.p('<input type="checkbox" id="'||l_id||
                '" name="F'||lpad(to_char(p_id),2,'00')||
                '" value="'||apex_escape.html(p_answer)||'" ');
            if p_answer = nvl(p_value_01,'mJh63') or 
               p_answer = nvl(p_value_02,'mJh63') or
               p_answer = nvl(p_value_03,'mJh63') or
               p_answer = nvl(p_value_04,'mJh63') or
               p_answer = nvl(p_value_05,'mJh63') or
               p_answer = nvl(p_value_06,'mJh63') or
               p_answer = nvl(p_value_07,'mJh63') or
               p_answer = nvl(p_value_08,'mJh63') or
               p_answer = nvl(p_value_09,'mJh63') or
               p_answer = nvl(p_value_10,'mJh63') or
               p_answer = nvl(p_value_11,'mJh63') or
               p_answer = nvl(p_value_12,'mJh63') 
               then
                sys.htp.prn(' checked="checked" ');
            end if;
            sys.htp.prn('>');
            sys.htp.prn('<label class="lp-Question-label" for="'||l_id||'">');
            sys.htp.prn(apex_escape.html(p_answer));
            sys.htp.prn('</label></div>');
        end if;
    end display_checkbox;
--
    procedure display_stack_rank (
       p_id     in number, 
       p_answer in varchar2 default null, 
       p_value  in varchar2 default null)
    is 
        l_id varchar2(30);
    begin
        g_cnt := g_cnt + 1;
        l_id := 'Q'||to_char((p_id * 10) + g_cnt);
        if p_answer is not null then
            sys.htp.p('<li data-value="'||g_cnt||'"');
            if p_value is not null then
               l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(p_value,',');
               FOR z IN 1..l_vc_arr2.count LOOP
                  if g_cnt = l_vc_arr2(z) then 
                     sys.htp.p(' data-sortable-index="' || to_char(z-1) ||'"');
                  end if;
               END LOOP;
            end if;
            sys.htp.p('>'||apex_escape.html(p_answer)||'</li>');
        end if;
    end display_stack_rank;
--
    procedure display_allocation (
       p_id     in number, 
       p_answer in varchar2 default null, 
       p_value  in varchar2 default null)
    is 
        l_id varchar2(30);
    begin
        g_cnt := g_cnt + 1;
        l_id := 'Q'||to_char((p_id * 10) + g_cnt);
        if p_answer is not null then
            sys.htp.p('<li data-allocate-value="'||nvl(p_value,0)||'">'||apex_escape.html(p_answer)||'</li>');
        end if;
    end display_allocation;
-- 
    procedure display_radio_group (
       p_id     in number, 
       p_answer in varchar2 default null, 
       p_value  in varchar2 default null)
    is 
        l_id varchar2(30);
    begin
        g_cnt := g_cnt + 1;
        l_id := 'Q'||to_char((p_id * 20) + g_cnt);
        if p_answer is not null then
            sys.htp.p('<div class="lp-Question-inputRadio">');
            sys.htp.p('<input type="radio" id="'||l_id||
                '" name="F'||lpad(to_char(p_id),2,'00')||
                '" value="'||apex_escape.html(p_answer)||'" ');
            if p_answer = nvl(p_value,'mjh63') then
                sys.htp.prn(' checked="checked" ');
            end if;
            sys.htp.prn('>');
            sys.htp.prn('<label class="lp-Question-label" for="'||l_id||'">');
            sys.htp.prn(apex_escape.html(p_answer));
            sys.htp.prn('</label></div>');
        end if;
    end display_radio_group;

    procedure display_textarea (p_id in number, p_answer in varchar2 default null, p_value in varchar2 default null)
    is 
    begin
        if p_answer is not null then
            sys.htp.p('<div class="lp-Question-inputTextarea"><textarea name="F'||lpad(to_char(c),2,'00')||
                '" rows="8" cols="80" maxlength="4000" wrap="virtual" id="'||c||
                '" class="textarea" style="resize: both;">');
            sys.htp.prn(p_value);
            sys.htp.prn('</textarea></div>');
        end if;
    end display_textarea;

    procedure display_text (p_id in number, p_answer in varchar2 default null, p_value in varchar2 default null)
    is 
    begin
        if p_answer is not null then
            sys.htp.p('<div class="lp-Question-inputText">');
            sys.htp.p('<input type="text" id="'||c||
                '" name="F'||lpad(to_char(c),2,'00')||
                '" class="text_field" size="32" maxlength="255" ');
            sys.htp.p('value="'|| p_value ||'" />');
            sys.htp.p('</div>');
        end if;
    end display_text;

begin
for c1 in (
    select poll_name, QUESTION_SET_ID, anonymous_yn, intro_text
    from EBA_LIVEPOLLS p
    where (status_id = 3 or 
           (status_id = 2 and
            EBA_LIVEPOLL.get_authorization_level(:APP_USER) >= 2))
      and id = :POLL_ID) loop
   --
   for c2 in (
      select image_filename, image_height, image_width, use_sections_yn
        from eba_livepoll_question_sets
       where id = c1.question_set_id
   ) loop
      if c2.image_filename is not null then
         sys.htp.p('<p><img src="'||apex_util.get_blob_file_src('P170_IMAGE_BLOB',c1.question_set_id)||'"');
         if c2.image_height is not null then
           sys.htp.p(' height="'|| c2.image_height ||'"');
         end if;
         if c2.image_width is not null then
            sys.htp.p(' width="'|| c2.image_width ||'"');
        end if;
         sys.htp.p(' /></p>');
      end if;
      l_use_sections_yn := c2.use_sections_yn;
   end loop;

   if c1.intro_text is not null then
      sys.htp.p('<p>'||apex_escape.html(c1.intro_text)||'</p><br/>');
   end if;

   for c2 in (
      select max(display_sequence) disp_seq
        from EBA_LIVEPOLL_QUESTIONS
       where question_set_id = c1.question_set_id
   ) loop
      l_max_question_seq := c2.disp_seq + 10;
   end loop;
   --
       for c2 in (
           select q.id question_id,
                  s.id section_id,
                  s.title section_title,
                  s.section_text,
                  s.image_filename,
                  s.image_width,
                  s.image_height,
                  q.question,
                  q.QUESTION_TYPE, q.mandatory_yn,
                  decode(q.answer_01,null,a.ANSWER_01,q.answer_01) answer_01,
                  decode(q.answer_01,null,a.ANSWER_02,q.answer_02) answer_02,
                  decode(q.answer_01,null,a.ANSWER_03,q.answer_03) answer_03,
                  decode(q.answer_01,null,a.ANSWER_04,q.answer_04) answer_04,
                  decode(q.answer_01,null,a.ANSWER_05,q.answer_05) answer_05,
                  decode(q.answer_01,null,a.ANSWER_06,q.answer_06) answer_06,
                  decode(q.answer_01,null,a.ANSWER_07,q.answer_07) answer_07,
                  decode(q.answer_01,null,a.ANSWER_08,q.answer_08) answer_08,
                  decode(q.answer_01,null,a.ANSWER_09,q.answer_09) answer_09,
                  decode(q.answer_01,null,a.ANSWER_10,q.answer_10) answer_10,
                  decode(q.answer_01,null,a.ANSWER_11,q.answer_11) answer_11,
                  decode(q.answer_01,null,a.ANSWER_12,q.answer_12) answer_12
           from EBA_LIVEPOLL_QUESTIONS q,
                EBA_LIVEPOLL_CANNED_ANSWERS a,
                eba_livepoll_sections s
           where q.question_type = a.code(+) and
                 q.QUESTION_SET_ID = c1.QUESTION_SET_ID and
                 q.section_id = s.id (+)
           order by  nvl(s.display_sequence,l_max_question_seq), s.title nulls last, q.display_sequence) loop
           c := c + 1;

           -- fetch answer values
           l_v01 := null;
           l_v02 := null;
           l_v03 := null;
           l_v04 := null;
           l_v05 := null;

           for c3 in (
              select answer_01 , answer_02, answer_03, answer_04, answer_05,
                     answer_06 , answer_07, answer_08, answer_09, answer_10, answer_11, answer_12
              from EBA_LIVEPOLL_RESULT_DETAILS 
              where result_id = :P50_RESULT_ID and
                    QUESTION_ID = c2.question_id
           ) loop
              if c2.QUESTION_TYPE in ('ALLOCATION') then
                 l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(c3.answer_01,',');
                 FOR z IN 1..l_vc_arr2.count LOOP
                    if z=1 then l_v01 := l_vc_arr2(z);
                    elsif z=2 then l_v02 := l_vc_arr2(z);
                    elsif z=3 then l_v03 := l_vc_arr2(z);
                    elsif z=4 then l_v04 := l_vc_arr2(z);
                    elsif z=5 then l_v05 := l_vc_arr2(z);
                    elsif z=6 then l_v06 := l_vc_arr2(z);
                    elsif z=7 then l_v07 := l_vc_arr2(z);
                    elsif z=8 then l_v08 := l_vc_arr2(z);
                    elsif z=9 then l_v09 := l_vc_arr2(z);
                    elsif z=10 then l_v10 := l_vc_arr2(z);
                    elsif z=11 then l_v11 := l_vc_arr2(z);
                    elsif z=12 then l_v12 := l_vc_arr2(z);
                    end if;
                 END LOOP;
              else
                 l_v01 := c3.answer_01;
                 l_v02 := c3.answer_02;
                 l_v03 := c3.answer_03;
                 l_v04 := c3.answer_04;
                 l_v05 := c3.answer_05;
                 l_v06 := c3.answer_06;
                 l_v07 := c3.answer_07;
                 l_v08 := c3.answer_08;
                 l_v09 := c3.answer_09;
                 l_v10 := c3.answer_10;
                 l_v11 := c3.answer_11;
                 l_v12 := c3.answer_12;
              end if;
           end loop;

           if l_use_sections_yn = 'Y' then
              if nvl(c2.section_id,-1) != nvl(l_section_id,0) then
                 if l_section_id is not null then
                    sys.htp.p('</div>');
                 end if;
                 sys.htp.p('<div class="lp-Question"><p class="lp-Question-questionText">');
                 sys.htp.p(apex_escape.html(nvl(c2.section_title,'Additional Questions')));
                 sys.htp.p('</p>');
                 if c2.section_text is not null then
                    sys.htp.p('<p>');
                    sys.htp.prn(replace(sys.htf.escape_sc(replace(c2.section_text,'<br>','++')),'++','<br>'));
                    sys.htp.p('</p>');
                 end if;
                 if c2.image_filename is not null then
                    sys.htp.p('<p><img src="'||apex_util.get_blob_file_src('P380_IMAGE_BLOB',c2.section_id)||'"');
                    if c2.image_height is not null then
                       sys.htp.p(' height="'|| c2.image_height ||'"');
                    end if;
                    if c2.image_width is not null then
                       sys.htp.p(' width="'|| c2.image_width ||'"');
                    end if;
                    sys.htp.p(' /></p>');
                 end if;
              end if;
              l_section_id := c2.section_id;
           end if;

           --F20 holds array of question IDs
           sys.htp.p('<input type="hidden" name="F50" value="'||c2.question_id||'">');
           
           sys.htp.p('<div class="lp-Question"><p class="lp-Question-questionText">');
           --sys.htp.prn(sys.htf.escape_sc(c2.question));
           sys.htp.prn(replace(sys.htf.escape_sc(replace(c2.question,'<br>','++')),'++','<br>'));

           -- this needs to be changed to something better
           if c2.mandatory_yn = 'Y' then 
              sys.htp.p(' *');
              l_mand := 'Y';
           end if;

           sys.htp.prn('</p>');

           for c3 in (
              select image_height, image_width
                from eba_livepoll_questions
               where id = c2.question_id
                 and image_filename is not null
           ) loop
              sys.htp.p('<p><img src="'||apex_util.get_blob_file_src('P180_IMAGE_BLOB',c2.question_id)||'"');
              if c3.image_height is not null then
                 sys.htp.p(' height="'|| c3.image_height ||'"');
              end if;
              if c3.image_width is not null then
                 sys.htp.p(' width="'|| c3.image_width ||'"');
              end if;
              sys.htp.p(' /></p>');
           end loop;

           if c2.QUESTION_TYPE = 'TEXTAREA' then
               display_textarea (p_id => c, p_answer => c2.ANSWER_01, p_value=>l_v01);
           elsif c2.QUESTION_TYPE = 'TEXT' then
               display_text (p_id => c, p_answer => c2.ANSWER_01, p_value=>l_v01);
           elsif c2.QUESTION_TYPE in ('STACK', 'STACK_RANK') then
               g_cnt := 0;
               sys.htp.prn('<ul data-sortable-name="F'||lpad(to_char(c),2,'00')||'" data-sortable-second="true">');
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_01, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_02, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_03, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_04, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_05, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_06, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_07, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_08, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_09, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_10, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_11, p_value => l_v01);
               display_stack_rank (p_id => c, p_answer => c2.ANSWER_12, p_value => l_v01);
               sys.htp.p('</ul>');
           elsif c2.QUESTION_TYPE in ('ALLOCATION') then
               g_cnt := 0;
               sys.htp.prn('<ul data-allocate-name="F'||lpad(to_char(c),2,'00')||'" data-allocate-max="100" data-allocate-suffix="dollar" data-allocate-step="1" data-allocate-restrict="proportion">');
               display_allocation (p_id => c, p_answer => c2.ANSWER_01, p_value => l_v01);
               display_allocation (p_id => c, p_answer => c2.ANSWER_02, p_value => l_v02);
               display_allocation (p_id => c, p_answer => c2.ANSWER_03, p_value => l_v03);
               display_allocation (p_id => c, p_answer => c2.ANSWER_04, p_value => l_v04);
               display_allocation (p_id => c, p_answer => c2.ANSWER_05, p_value => l_v05);
               display_allocation (p_id => c, p_answer => c2.ANSWER_06, p_value => l_v06);
               display_allocation (p_id => c, p_answer => c2.ANSWER_07, p_value => l_v07);
               display_allocation (p_id => c, p_answer => c2.ANSWER_08, p_value => l_v08);
               display_allocation (p_id => c, p_answer => c2.ANSWER_09, p_value => l_v09);
               display_allocation (p_id => c, p_answer => c2.ANSWER_10, p_value => l_v10);
               display_allocation (p_id => c, p_answer => c2.ANSWER_11, p_value => l_v11);
               display_allocation (p_id => c, p_answer => c2.ANSWER_12, p_value => l_v12);
               sys.htp.p('</ul>');
           elsif c2.QUESTION_TYPE = 'RADIO_GROUP' then
               g_cnt := 0;
               display_radio_group (p_id => c, p_answer => c2.ANSWER_01, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_02, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_03, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_04, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_05, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_06, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_07, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_08, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_09, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_10, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_11, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_12, p_value => l_v01);
               
           elsif c2.QUESTION_TYPE = 'CHECKBOX' then
               g_cnt := 0;
               display_checkbox (p_id => c, p_answer => c2.ANSWER_01, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_02, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_03, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_04, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_05, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_06, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_07, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_08, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_09, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_10, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_11, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
               display_checkbox (p_id => c, p_answer => c2.ANSWER_12, 
                    p_value_01 => l_v01, 
                    p_value_02 => l_v02, 
                    p_value_03 => l_v03, 
                    p_value_04 => l_v04, 
                    p_value_05 => l_v05,
                    p_value_06 => l_v06, 
                    p_value_07 => l_v07, 
                    p_value_08 => l_v08, 
                    p_value_09 => l_v09, 
                    p_value_10 => l_v10, 
                    p_value_11 => l_v11, 
                    p_value_12 => l_v12);
           else
               g_cnt := 0;
               display_radio_group (p_id => c, p_answer => c2.ANSWER_01, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_02, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_03, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_04, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_05, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_06, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_07, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_08, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_09, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_10, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_11, p_value => l_v01);
               display_radio_group (p_id => c, p_answer => c2.ANSWER_12, p_value => l_v01);
           end if;

           -- Close lp-Question div
           htp.p('</div>');
           --

           if c = 20 then
              exit;
           end if;
       end loop; -- c2

       if l_use_sections_yn = 'Y' then
          sys.htp.p('</div>');
       end if;

       if l_mand = 'Y' then
          sys.htp.p('<p>* indicates mandatory questions</p>');
       end if;

end loop; -- c1
end;

---
---
---
SELECT poll_id,
       poll, 
       POLL_DETAILS,
       ANONYMOUS,
       answers_updatable,
       results_viewable,
       Scored,
       created,
       created_by,
       updated,
       updated_by,
       status,
       STATUS_COLOR,
       is_open,
       question_set,
       poll_type,
       questions,
       invitations,
       responses,
       started,
       ended,
       last_action,
      'Take It' actions,
      case when take_status in ('CAN_TAKE_IT','HAS_ERRORS','CAN_UPDATE') and questions > 0
           then '<a class="t-Button t-Button--small t-Button--hot t-Button--simple t-Button--stretch" href="'
               ||apex_util.prepare_url('f?p='||:APP_ID||':50:'||:APP_SESSION||':::50:LPOLL_ID:'||poll_id)
               ||'">'||apex_lang.message(take_status)||'</a>'
           else '' end action_URL
from
(
    SELECT 
    p.id poll_id,
       p.POLL_NAME poll, 
       p.POLL_DETAILS,
       decode(p.ANONYMOUS_YN,'Y','Yes','N','No',p.ANONYMOUS_YN) ANONYMOUS,
       decode(p.CAN_UPDATE_ANSWERS_YN,'Y','Yes','N','No',p.CAN_UPDATE_ANSWERS_YN) answers_updatable,
       decode(p.ALL_VIEW_RESULTS_YN,'Y','Viewable by Invitees','N','Viewable by Named Users',p.ALL_VIEW_RESULTS_YN) results_viewable,
       decode(p.ENABLE_SCORE_YN,'Y','Yes','N','No',p.ENABLE_SCORE_YN) Scored,
       p.created,
       lower(p.created_by) created_by,
       p.updated,
       lower(p.updated_by) updated_by,
       p.status_id || case when p.status_id = 3 then p.invite_only_yn end status,
       s.STATUS_COLOR,
       decode(s.IS_OPEN_YN,'Y','Yes','N','No',s.IS_OPEN_YN) is_open,
       q.NAME question_set,
       decode(q.POLL_OR_QUIZ,'P','Poll','Q','Quiz',q.POLL_OR_QUIZ) poll_type,
       (select count(*) from EBA_LIVEPOLL_QUESTIONS qu where qu.QUESTION_SET_ID = q.id) questions,
       nvl((select max(x.updated) from eba_livepoll_results x
          where x.poll_id = p.id
            and nvl(x.is_valid_yn,'Y') = 'Y'),p.created) last_action,
       nvl((select count(distinct respondent_id)
          from eba_livepoll_comm_invites c,
               eba_livepoll_invites i
         where c.poll_id = p.id
           and c.id = i.comm_invite_id),0) invitations,
       nvl((select count(*)
              from EBA_LIVEPOLL_RESULTS r
             where r.poll_ID = p.id
               and nvl(r.is_valid_yn,'Y') = 'Y'),0)  responses,
      --
      (select max(p.start_time) started
              from EBA_LIVEPOLL_RESULTS r
             where r.poll_ID = p.id
               and nvl(r.is_valid_yn,'Y') = 'Y') started,
      --
      (select max(p.stop_time) ended
              from EBA_LIVEPOLL_RESULTS r
             where r.poll_ID = p.id
               and nvl(r.is_valid_yn,'Y') = 'Y') ended,
      'Take It' actions,
      eba_livepoll.poll_take_status(
                p_poll_id => p.id,
                p_app_user => :APP_USER,
                p_app_session => :APP_SESSION) take_status
from   EBA_LIVEPOLLS p,
       eba_livepoll_question_sets q,
       EBA_LIVEPOLL_STATUS_CODES s
where 
       p.question_set_id = q.id and
       s.id = p.status_id
);


--------------- Page 200 Question Sets

-- Classic report to show the questions

select
    q.id,
    s.title,
    q.question,
    q.created,
    q.updated,
    q.display_sequence, 
    q.mandatory_yn,
    case when q.image_blob is not null then
        'Yes'
    else
        'No'
    end has_image_yn,
    case when q.question_type in ('TEXTAREA','TEXT') then null
         else decode(
                use_custom_answers_yn,
                'N', 
                a.answer_01||
                        decode(a.answer_02,null,null,', '||a.answer_02)||
                        decode(a.answer_03,null,null,', '||a.answer_03)||
                        decode(a.answer_04,null,null,', '||a.answer_04)||
                        decode(a.answer_05,null,null,', '||a.answer_05)||
                        decode(a.answer_06,null,null,', '||a.answer_06)||
                        decode(a.answer_07,null,null,', '||a.answer_07)||
                        decode(a.answer_08,null,null,', '||a.answer_08)||
                        decode(a.answer_09,null,null,', '||a.answer_09)||
                        decode(a.answer_10,null,null,', '||a.answer_10)||
                        decode(a.answer_11,null,null,', '||a.answer_11)||
                        decode(a.answer_12,null,null,', '||a.answer_12)
                ,q.answer_01||
                        decode(q.answer_02,null,null,', '||q.answer_02)||
                        decode(q.answer_03,null,null,', '||q.answer_03)||
                        decode(q.answer_04,null,null,', '||q.answer_04)||
                        decode(q.answer_05,null,null,', '||q.answer_05)||
                        decode(q.answer_06,null,null,', '||q.answer_06)||
                        decode(q.answer_07,null,null,', '||q.answer_07)||
                        decode(q.answer_08,null,null,', '||q.answer_08)||
                        decode(q.answer_09,null,null,', '||q.answer_09)||
                        decode(q.answer_10,null,null,', '||q.answer_10)||
                        decode(q.answer_11,null,null,', '||q.answer_11)||
                        decode(q.answer_12,null,null,', '||q.answer_12)
            ) end answers,
    case when :p200_poll_or_quiz = 'Q' and question_type = 'CHECKBOX'
         then eba_livepoll_quiz.delim_answers_disp(q.correct_answer)
         else q.correct_answer
         end correct_answer,
    decode(
        q.question_type,
       'RADIO_GROUP','Pick One',
       'CHECKBOX'   ,'Pick Many',
       'PICK_TWO'   ,'Pick Two',
       'ALLOCATION' ,'Allocate $100',
       'STACK'      ,'Stack Rank',
       'TEXTAREA'   ,'Free form text',
       'TEXT'       ,'Text field',
       'Canned Answers'
    ) question_type,
     use_custom_answers_yn 
from eba_livepoll_questions q,
     eba_livepoll_canned_answers a,
     eba_livepoll_sections s
where q.question_set_id = :P200_ID and
     q.question_type = a.code(+) and
     q.section_id = s.id (+)
order by nvl(
        s.display_sequence,
        :p200_max_question_seq), 
    s.title nulls last,
    q.display_sequence;

---- History 

select 
-- Update Sesion
    ''                                  comment_modifiers, 
    'Question Update'                   note_type,
    replace(initcap(replace(
            replace(f.column_name,
                '_ID',null)
        ,'_',' ')
    ),chr(10),'<br>')                   comment_text,
    ' changed from "'||f.old_value||'"' attribute_1,
    ' to "'||f.new_value||'"'           attribute_2,
    ' '                                 attribute_3,
    ' '                                 attribute_4,
    lower(f.changed_by)                 user_name,
    apex_util.get_since(f.change_date) comment_date,
    ' '                                link,
    null                               update_id,
    f.change_date                      change_date,
    ''                                 actions,
    upper(
        decode(instr(
            replace(f.changed_by,'.',' ')
            ,' '),
            0, 
            substr(f.changed_by,1,2),
            substr(f.changed_by,1,1)
            ||substr(f.changed_by,
            instr(replace(
                f.changed_by,'.',' ')
            ,' ')+1,1)
           ))                            user_icon
from eba_livepoll_history f,
    eba_livepoll_questions q
where f.table_name = 'QUESTIONS'
    and f.component_id = q.id
    and q.question_set_id = :P200_ID
    and ( f.column_name != 'QUESTION'
        or ( f.old_value is not null and f.new_value is not null ) )
union all
-- Questions Added
select  
    '' comment_modifiers, 
    'Question Added' comment_type,
    replace(initcap(replace(replace(f.column_name,'_ID',null),'_',' ')),chr(10),'<br>') comment_text,
    ' ' attribute_1,
    ' added "'||f.new_value||'"' attribute_2,
    ' ' attribute_3,
    ' ' attribute_4,
    lower(f.changed_by) user_name,
    apex_util.get_since(f.change_date) comment_date,
    ' ' link,
    null update_id,
    f.change_date,
    '' actions,
    upper(
          decode(instr(replace(f.changed_by,'.',' '),' '),
                 0, 
                 substr(f.changed_by,1,2),
                 substr(f.changed_by,1,1)||substr(f.changed_by,instr(replace(f.changed_by,'.',' '),' ')+1,1)
           )) user_icon
from eba_livepoll_history f
where f.table_name = 'QUESTIONS'
    and f.question_set_id = :P200_ID
    and f.column_name = 'QUESTION'
    and f.old_value is null
union all
-- Questions Deleted
select 
    '' comment_modifiers, 
    'Question Removed' comment_type,
    replace(initcap(replace(replace(f.column_name,'_ID',null),'_',' ')),chr(10),'<br>') comment_text,
    ' removed "'||f.old_value||'"' attribute_1,
    ' ' attribute_2,
    ' ' attribute_3,
    ' ' attribute_4,
    lower(f.changed_by) user_name,
    apex_util.get_since(f.change_date) comment_date,
    ' ' link,
    null update_id,
    f.change_date,
    '' actions,
    upper(
          decode(instr(replace(f.changed_by,'.',' '),' '),
                 0, 
                 substr(f.changed_by,1,2),
                 substr(f.changed_by,1,1)||substr(f.changed_by,instr(replace(f.changed_by,'.',' '),' ')+1,1)
           )) user_icon
from eba_livepoll_history f
where f.table_name = 'QUESTIONS'
    and f.question_set_id = :P200_ID
    and f.column_name = 'QUESTION'
    and f.new_value is null
order by 12 desc

-- Short Change History

------------------ Page 200

select * from EBA_LIVEPOLL_EMAIL_HIST;

select * from EBA_LIVEPOLL_RESPONDENTS;

select * from EBA_LIVEPOLLS;

select * from EBA_LIVEPOLL_STATUS_CODES;

select * from EBA_LIVEPOLL_RESULTS;

select * from EBA_LIVEPOLL_RESULT_DETAILS;

select * from EBA_LIVEPOLL_QUESTION_SETS;

select * from EBA_LIVEPOLL_QUESTIONS where question_set_id=195266197213297832407123705062303404378;

select * from EBA_LIVEPOLL_SECTIONS;

select * from EBA_LIVEPOLL_EMAIL_TEMPLATES;

select * from EBA_LIVEPOLL_EMAIL_STYLES;

select * from EBA_LIVEPOLL_APPLICATION_LOG;

select * from EBA_LIVEPOLL_ERRORS;

select * from EBA_LIVEPOLL_ERROR_LOG;

select * from EBA_LIVEPOLL_USER_LOG;

select * from EBA_LIVEPOLL_NOTIFICATIONS;

select * from EBA_LIVEPOLL_SUPP_WELCOME_TEXT;

select * from eba_livepoll_history;

select * from eba_livepoll_questions;
select * from eba_livepoll_canned_answers; -- possible answer types

select * from user_tab_comments where table_name like 'EBA_LIVEPOLL%';

select EBA_LIVEPOLL_fw.compress_int(12),  to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'), sys_guid() from dual;

select mod(25, 10 + 26), chr(ascii('A')+25), chr(ascii('0')), floor(38/( 10 + 26)) from dual;

Publish my quiz as a quiz :

1. Create question Set
2. Publish Question set as Quiz

Require login
Anonymize
Can update answers

Question : Option-1, option-2, option-3, option-4

----- My Data objects

MQT - My Quiz Test

Thanks for your confirmation.

As I mentioned earlier I did almost everything right : got the parking space reserved/alloted for me. Obtained the parking permit. Obtained the fob for the security gate. Parked the vechile in the space reserved and dedicated for me. Did my best to display the parking permit. Don't know how but it fell off inside the car by accident.

Despite putting my best effort to follow the correct process the rules and regulations followed by the ticketing system is imposing penalty on me. That is the reason it seems unfair to me and looks like system is using the rules to earn revenue for the department rather finding the real culprits.

Can you please explain me what is the point having such rules and following them strictly when this can not be used to differentiate real offender versus a innocent person.

