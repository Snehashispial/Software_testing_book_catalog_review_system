mtype={loginreq,authenticationreq,valid_invalid,loginsuccessful_failed};
			chan chan1=[1] of {mtype};
			chan chan2=[1] of {mtype};
			
			proctype User(chan in, out)
			{
			do
			:: in ! loginreq ;
			in ? loginsuccessful_failed;
			od
			}
			
			proctype System(chan in, out)
			{
			do
			:: out ? loginreq ;
			in ! authenticationreq;
			in ? valid_invalid;
			out ! loginsuccessful_failed;
			od
			}
			
			proctype Server(chan in, out)
			{
			do
			:: out ? authenticationreq ;
			out ! valid_invalid;
			od
			}
			
			init
			{
			run User(chan1,chan2);
			run System(chan2,chan1);
			run Server(chan1,chan2);
			}
			
