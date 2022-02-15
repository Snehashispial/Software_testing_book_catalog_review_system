mtype={Adduser, user_added, remove_user, user_removed, add_new_edition, neweditionadded,
	                                        remove_book, bookremoved, edit_profile, profile_edited}
	                         
	                            chan chan1=[2] of {mtype,bit};
	                            chan chan2=[2] of {mtype,bit};
		
		proctype Admin(chan in, out)
		{ 
                                    bit sndbit,ackbit;
		   do
		   :: in ! Adduser,sndbit ->
                                  	 out ? user_added,ackbit;
		  in ! remove_user,sndbit;
		 out ? user_removed,ackbit;
		 in ! add_new_edition,sndbit;
		 out ? neweditionadded,ackbit;
		 in ! remove_book,sndbit ;
		 out ? bookremoved,ackbit ;
		 in ! edit_profile,sndbit;
		 out ? profile_edited,ackbit;
		od
		}
		
		proctype Server(chan in, out)
		{
                                 bit recbit, sndbit;
		do
		 :: out ? Adduser,recbit ->
		   in !  user_added,sndbit ;
		 out ? remove_user,recbit;
		   in ! user_removed,sndbit;
		 out ? add_new_edition,recbit ;
		  in ! neweditionadded,sndbit ;
		 out ?  remove_book,recbit;
		  in ! bookremoved,sndbit;
		 out ? edit_profile,recbit;
		 in ! profile_edited,sndbit;
		od
		} 
		
		init
		{
		run Admin(chan1,chan2);
		run Server(chan2,chan1)
		}
		
		
		
