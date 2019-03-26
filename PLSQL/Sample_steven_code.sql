CREATE OR REPLACE PACKAGE meme_tracker
   IS
      PROCEDURE reset_memes;

      FUNCTION already_saw_meme (
            meme_target_in VARCHAR2, meme_in IN VARCHAR2)
         RETURN BOOLEAN;

      PROCEDURE add_meme (
         meme_target_in VARCHAR2, meme_in IN VARCHAR2);
	procedure print_array;
END; 
/

CREATE OR REPLACE PACKAGE BODY meme_tracker
IS
   SUBTYPE meme_target_t IS VARCHAR2(100);
   SUBTYPE meme_t IS VARCHAR2(1000);
   c_was_processed CONSTANT BOOLEAN := TRUE;

   TYPE memes_for_target_t IS TABLE OF BOOLEAN INDEX BY meme_t;
   TYPE processed_memes_t IS TABLE OF memes_for_target_t INDEX BY meme_target_t;
   g_processed_memes processed_memes_t;

   PROCEDURE reset_memes
   IS
   BEGIN
      g_processed_memes.DELETE;
   END;

   FUNCTION already_saw_meme (
         meme_target_in VARCHAR2, meme_in IN VARCHAR2)
      RETURN BOOLEAN
   IS
   BEGIN
      RETURN g_processed_memes 
               (meme_target_in)
                   (meme_in) = c_was_processed;
   EXCEPTION 
      /* PL/SQL raises NDF if you try to "read" a collection
         element that does not exist */
      WHEN NO_DATA_FOUND THEN RETURN FALSE;
   END;

   PROCEDURE add_meme (
      meme_target_in VARCHAR2, meme_in IN VARCHAR2)
   IS
   BEGIN
      g_processed_memes (meme_target_in)(meme_in) 
         := c_was_processed;   
   END;
   
   procedure print_array
   is
   l_index   varchar2(1000);
   l_index2   varchar2(1000);
   begin
	l_index := g_processed_memes.first;
	while (l_index is not null)
	loop
		DBMS_OUTPUT.put_line('l_index-'||l_index);
		l_index2 := g_processed_memes(l_index).first;
		
		while (l_index2 is not null)
		loop
			DBMS_OUTPUT.put_line('l_index2-'||l_index2);
			l_index2 := g_processed_memes(l_index).next(l_index2);
		end loop;
		l_index := g_processed_memes.next(l_index);
	end loop;
   end;
   
END;
/

BEGIN
	meme_tracker.reset_memes;
	meme_tracker.add_meme ('DOG', 'CAT');
	meme_tracker.add_meme ('HUMAN', 'CAT VIDEO');
	meme_tracker.add_meme ('HUMAN', 'HONEY BOO BOO');

	IF meme_tracker.already_saw_meme ('DOG', 'CAT')
	THEN
	  DBMS_OUTPUT.PUT_LINE ('DOG-CAT-FOUND');
	END IF;

	IF NOT meme_tracker.already_saw_meme ('DOG', 'CAT VIDEO')
	THEN
	  DBMS_OUTPUT.PUT_LINE ('DOG-CAT VIDEO-NOT FOUND');
	END IF;
	meme_tracker.print_array;
	
END;
/

DROP PACKAGE MEME_TRACKER;


