-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity multU is
 generic (n : integer:=16);
 port( a,b: in std_logic_vector( n-1 downto 0);
        product : out std_logic_vector( n*2-1 downto 0)
        );
end multU;

architecture behav of multU is

component fa is
  port(
    A : in std_logic;
    B : in std_logic;
    Cin : in std_logic;
    
    Sum : out std_logic;
    Cout : out std_logic);
  end component;
  type car is Array(n-2 downto 0) of std_logic_vector(n-1 downto 0);
  type sm is Array(n-2 downto 0) of std_logic_vector(n-2 downto 0);
  type inp is array (n-2 downto 0, n-1 downto 0, 2 downto 0) of std_logic;
  signal carries : car;--:= (others =>(others =>'0'));
  signal isum : sm;--:= (others =>(others =>'0'));
  signal products : std_logic_vector(n*2-1 downto 0):= (others => '0');
  signal input_abc: inp;  
  
begin

---------------------------------------- input loop
    inpr:for i in 1 to n-2 generate
    input_abc(0,i,0) <= a(i+1) and b(0);
    input_abc(0,i,1) <= a(i) and b(0+1);
    input_abc(0,i,2) <= a(i-1) and b(0+2);    
    end generate inpr;
    input_abc(0,n-1,1) <= a(n-1) and b(1);
    input_abc(0,n-1,2) <= a(n-2) and b(2);
    input_abc(0,0,0) <= a(1) and b(0);
    input_abc(0,0,1) <= a(0) and b(1);
inpmc :for j in 1 to n-3 generate     
    inpmr:for i in 1 to n-1 generate
    input_abc(j,i,0) <=a(i) and b(j+1);
    input_abc(j,i,1) <= a(i-1) and b(j+2);
    input_abc(j,i,2) <= '0';    
    end generate inpmr;
    end generate inpmc;    
    input_abc(n-2,n-1,0) <= a(n-1) and b(n-1) ;
    
    
products(0) <= a(0) and b(0);
  col1 :for j in 0 to n-2 generate 
      RowL: for i in 0 to n-1 generate 
      ------------------------------------------- first of the adders
          firstadder1:if (i = 0 and j= 0) generate                        
            Addl: fa port map (A =>input_abc(0,0,0) ,B =>input_abc(0,0,1),Cin => '0' , Sum => products(1),Cout =>carries(0)(0));
            end generate firstadder1;
          lastadder1: if ( i=n-1 and j =0) generate                
            AddN : fa port map ( A=>'0' , B=> input_abc(0,i,1) ,Cin=>input_abc(0,i,2),Sum => isum(0)(n-2), Cout => carries(0)(n-1));
          end generate lastadder1;
          genadder1:if (j = 0 and i>0 and i< n-1) generate
            AddN : fa port map ( A=>input_abc(0,i,0) , B=> input_abc(0,i,1) ,Cin=>input_abc(0,i,2),Sum => isum(0)(i-1), Cout => carries(0)(i));
          end generate genadder1; 
          
          ------------------------------------------- middle adders
          firstaddern:if (i = 0 and 0<j and j< n-2) generate
            Addl: fa port map (A =>isum(j-1)(0) ,B =>'0',Cin => carries(j-1)(0) , Sum => products(j+1),Cout =>carries(j)(0));
          end generate firstaddern;
          lastaddern: if ( i=n-1 and 0<j and j< n-2) generate
            AddN : fa port map ( A=>input_abc(j,i,0) , B=> input_abc(j,i,1) ,Cin=>carries(j-1)(n-1),Sum => isum(j)(n-2), Cout => carries(j)(n-1));
          end generate lastaddern;
          genaddern:if (0<i and i< n-1 and 0<j and j< n-2) generate
            AddN : fa port map ( A=>isum(j-1)(i) , B=> input_abc(j,i,1) ,Cin=>carries(j-1)(i),Sum => isum(j)(i-1), Cout => carries(j)(i));
          end generate genaddern; 
          
          ---------------------------------------- last of the adders
           firstaddern1:if (i = 0 and j= n-2) generate
             Addl: fa port map (A =>isum(j-1)(0) ,B =>carries(j-1)(0),Cin => '0' , Sum => products(n-1),Cout =>carries(j)(0));
          end generate firstaddern1;
          lastaddern1: if ( i=n-1 and j =n-2) generate
            AddN : fa port map ( A=>input_abc(j,i,0) , B=> carries(j-1)(n-1) ,Cin=>carries(j)(n-2),Sum => products(N*2-2), Cout => products(N*2-1));
          end generate lastaddern1;
          genaddern1:if (j = n-2 and 0 < i and i < n-1) generate
            AddN : fa port map ( A=>isum(j-1)(i) , B=> carries(j-1)(i) ,Cin=>carries(j)(i-1),Sum => products(n-1+i), Cout => carries(j)(i));
          end generate genaddern1; 
         
           
      end generate;
  end generate;

  product <= products ;	
end behav;
    
    
    