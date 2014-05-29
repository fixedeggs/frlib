classdef reducedPrimalPrg < frlibPrg

    properties (GetAccess=protected)

        Uarry
        Varry
        Sarry
        Karry
        Aorig
        corig
        Korig
        noReductions

    end

    methods

        
        function self = reducedPrimalPrg(A,b,c,K,Karry,U,S)
         
            if (length(U) > 0)
                
                cone = ConeBase(K);

                Tuu = cone.BuildMultMap(U{end},U{end});
                Ar = [A*Tuu'];
                cr = [c*Tuu'];
                Kr = ConeBase.cleanK(Karry{end});
                
                noReductions = 0;

            else
               
                Kr = K;
                Ar = A;
                cr = c;
               
                noReductions = 1;

            end

            
            self@frlibPrg(Ar,b,cr,Kr);
            self.Uarry = U;
            self.Sarry = S;
            self.Karry = Karry;
            self.Aorig = A;
            self.corig = c;
            self.Korig = K;
            self.noReductions = noReductions;
            
            
        end

        function [x] = RecoverPrimal(self,x)

            if (self.noReductions)
                return
            end

            face = ConeBase(self.Karry{end});
            transposeU = 0;
            Tuu = face.BuildMultMap(self.Uarry{end},self.Uarry{end},transposeU);
            x = Tuu*x;

        end
        
        function PrintStats(self)
            facialRed.PrintStats(self.K,self.Korig);
        end
        
        
        

    end

end
