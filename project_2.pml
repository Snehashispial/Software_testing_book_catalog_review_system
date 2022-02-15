    mtype={searchbook,notfound,Again_search,found,viewbookdetails,review_rating};
		chan chan1=[2] of {mtype,bit};
		chan chan2=[2] of {mtype,bit};
		
		proctype User(chan in, out)
		{
                                  bit sndbit,ackbit;
		do
		:: in ! searchbook,sndbit ;
		out ? notfound,ackbit;
                                in ! Again_search,sndbit;
                                out ? found,ackbit;
                                 in ! viewbookdetails,sndbit;
                                 out ! review_rating,sndbit;
		od
		}
		
		proctype Bookfort_interface(chan in, out)
		{
                                  bit recbit,sndbit;
		do
		:: out ? searchbook,recbit ;
		in ! notfound,sndbit;
		out ? Again_search,recbit;
		in ! found,sndbit;
                                 out? viewbookdetails,recbit;
                                  in ? review_rating,recbit;
		od
		}
		
		init
		{
		run User(chan1,chan2);
		run Bookfort_interface (chan2,chan1);
		}
		
