
using OrdinaryDiffEq, ParameterizedFunctions, Plots, DiffEqDevTools
gr()

f = @ode_def Hires begin
  dy1 = -1.71*y1 + 0.43*y2 + 8.32*y3 + 0.0007
  dy2 = 1.71*y1 - 8.75*y2
  dy3 = -10.03*y3 + 0.43*y4 + 0.035*y5
  dy4 = 8.32*y2 + 1.71*y3 - 1.12*y4
  dy5 = -1.745*y5 + 0.43*y6 + 0.43*y7
  dy6 = -280.0*y6*y8 + 0.69*y4 + 1.71*y5 -
           0.43*y6 + 0.69*y7
  dy7 = 280.0*y6*y8 - 1.81*y7
  dy8 = -280.0*y6*y8 + 1.81*y7
end

u0 = zeros(8)
u0[1] = 1
u0[8] = 0.0057
prob = ODEProblem(f,u0,(0.0,321.8122))

sol = solve(prob,Rodas5(),abstol=1/10^14,reltol=1/10^14)
test_sol = TestSolution(sol)
abstols = 1.0 ./ 10.0 .^ (4:11)
reltols = 1.0 ./ 10.0 .^ (1:8);


plot(sol)


plot(sol,tspan=(0.0,5.0))

abstols = 1.0 ./ 10.0 .^ (5:8)

reltols = 1.0 ./ 10.0 .^ (1:4);
Names = [".9" ".8" ".7" ".6" ".5"]

setups = [
		  Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>9//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>8//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>5//10)
          ]
wp_Predictive = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_Predictive,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Predictive")

setups = [
		  Dict(:alg=>ROCK2(controller=:Standard),:gamma=>9//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>8//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>5//10)
          ]
wp_Standard = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_Standard,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Standard")

setups = [
		  Dict(:alg=>ROCK2(controller=:PI),:gamma=>9//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>8//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>5//10)
          ]
wp_PI = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 PI")

plot(wp_Predictive,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Predictive_Hires_OnlySpeed")
savefig("../ROCK2 Predictive_Hires_OnlySpeed.svg")
plot(wp_Standard,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Standard_Hires_OnlySpeed")
savefig("../ROCK2 Standard_Hires_OnlySpeed.svg")
plot(wp_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 PI_Hires_OnlySpeed")
savefig("../ROCK2 PI_Hires_OnlySpeed.svg")

plot(wp_Predictive[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Predictive_Hires_OnlySpeed")
plot!(wp_Predictive[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Predictive_Hires_OnlySpeed")
savefig("../ROCK2 Predictive_Hires_OnlySpeed2.svg")

plot(wp_Predictive[4],label="Pred .6",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Predictive[5],label="Pred .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_PI[3],label="PI .7",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_PI[4],label="PI .6",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_PI[5],label="PI .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Standard[2],label="Std .8",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Standard[3],label="Std .7",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
savefig("../ROCK2 OverAll_Hires_OnlySpeed.svg")

plot(wp_Predictive[4],label="Pred .6",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Predictive[5],label="Pred .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Standard[2],label="Std .8",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_Standard[3],label="Std .7",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
savefig("../ROCK2 OverAll_Hires_OnlySpeed2.svg")

plot(wp_PI[5],label="PI .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_PI[4],label="PI .6",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
plot!(wp_PI[3],label="PI .7",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK2 Overall")
savefig("../ROCK2 OverAll_Hires_OnlySpeed3.svg")

setups = [
		  Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>9//10)
          Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>8//10)
          Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>7//10)
          Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>6//10)
          Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>5//10)
          ]
wp_R4_Predictive = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_R4_Predictive,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Predictive")

setups = [
		  Dict(:alg=>ROCK4(controller=:Standard),:gamma=>9//10)
          Dict(:alg=>ROCK4(controller=:Standard),:gamma=>8//10)
          Dict(:alg=>ROCK4(controller=:Standard),:gamma=>7//10)
          Dict(:alg=>ROCK4(controller=:Standard),:gamma=>6//10)
          Dict(:alg=>ROCK4(controller=:Standard),:gamma=>5//10)
          ]
wp_R4_Standard = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_R4_Standard,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Standard")

setups = [
		  Dict(:alg=>ROCK4(controller=:PI),:gamma=>9//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>8//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>6//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>5//10)
          ]
wp_R4_PI = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=10,maxiters=1e5)
plot(wp_R4_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 PI")


plot(wp_R4_Predictive,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Predictive_Hires_OnlySpeed")
savefig("../ROCK4 Predictive_Hires_OnlySpeed.svg")
plot(wp_R4_Standard,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Standard_Hires_OnlySpeed")
savefig("../ROCK4 Standard_Hires_OnlySpeed.svg")
plot(wp_R4_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 PI_Hires_OnlySpeed")
savefig("../ROCK4 PI_Hires_OnlySpeed.svg")

plot(wp_R4_Predictive[1],label="Pred .9",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
plot!(wp_R4_Predictive[2],label="Pred .8",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
plot!(wp_R4_Predictive[5],label="Pred .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
plot!(wp_R4_PI[1],label="PI .9",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
plot!(wp_R4_PI[5],label="PI .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
savefig("../ROCK4 Overall_Hires_OnlySpeed.svg")

plot(wp_R4_PI[1],label="PI .9",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
plot!(wp_R4_PI[5],label="PI .5",dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="ROCK4 Overall_Hires_OnlySpeed")
savefig("../ROCK4 Overall_Hires_OnlySpeed.svg2")

names2 = ["R2 Pred 8" "R2 Pred 6" "R2 Pred 5" "R2 PI 9" "R2 PI 7" "R2 PI 6" "R2 PI 5" "R2 Std 8" "R2 Std 7" "R4 Pred 9" "R4 Pred 8" "R4 PI 9" "R4 PI 5"]

setups = [
		  Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>8//10)	
		  Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>5//10)
		  Dict(:alg=>ROCK2(controller=:PI),:gamma=>9//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>5//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>8//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>7//10)
   		  Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>9//10)
   		  Dict(:alg=>ROCK4(controller=:Predictive),:gamma=>8//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>9//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>5//10)
          ]

wp_l2 = WorkPrecisionSet(prob,abstols,reltols,setups;names=names2,dense = false,verbose=false,
                      appxsol=test_sol,maxiters=Int(1e5),error_estimate=:l2)
plot(wp_l2,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_l2_Hires.svg")

plot(wp_l2[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[7],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[8],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
plot!(wp_l2[9],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK2_Overall")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_l2_Hires_ROCK2.svg")

plot(wp_l2[10],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK4_Overall")
plot!(wp_l2[11],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK4_Overall")
plot!(wp_l2[12],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK4_Overall")
plot!(wp_l2[13],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_ROCK4_Overall")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_l2_Hires_ROCK4.svg")

wp_L2 = WorkPrecisionSet(prob,abstols,reltols,setups;
                      names=names2,appxsol=test_sol,maxiters=Int(1e5),error_estimate=:L2)
plot(wp_L2,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_L2_Hires.svg")

plot(wp_L2[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[7],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[8],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
plot!(wp_L2[9],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK2_Overall")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_L2_Hires_ROCK2.svg")

plot(wp_L2[10],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK4_Overall")
plot!(wp_L2[11],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK4_Overall")
plot!(wp_L2[12],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK4_Overall")
plot!(wp_L2[13],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_ROCK4_Overall")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_L2_Hires_ROCK4.svg")

names2 = ["R2 PI 9" "R2 PI 8" "R2 PI 7" "R2 PI 6" "R2 PI 5" "R4 PI 9" "R4 PI 8" "R4 PI 7" "R4 PI 6" "R4 PI 5" ]

setup  = [
		  Dict(:alg=>ROCK2(controller=:PI),:gamma=>9//10)
		  Dict(:alg=>ROCK2(controller=:PI),:gamma=>8//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>6//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>5//10)
		  Dict(:alg=>ROCK4(controller=:PI),:gamma=>9//10)
		  Dict(:alg=>ROCK4(controller=:PI),:gamma=>8//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>6//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>5//10)
          ]
wp_l2_PI = WorkPrecisionSet(prob,abstols,reltols,setups;names=names2,dense = false,verbose=false,
                      appxsol=test_sol,maxiters=Int(1e5),error_estimate=:l2)
plot(wp_l2_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")

plot(wp_l2_PI[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")

plot(wp_l2_PI[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[7],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[8],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[9],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")
plot!(wp_l2_PI[10],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_l2_PI")



wp_L2_PI = WorkPrecisionSet(prob,abstols,reltols,setups;
                      names=names2,appxsol=test_sol,maxiters=Int(1e5),error_estimate=:L2)
plot(wp_L2_PI,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")

plot(wp_L2_PI[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")


plot(wp_L2_PI[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[7],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[8],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[9],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")
plot!(wp_L2_PI[10],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_L2_PI")


abstols = 1.0 ./ 10.0 .^ (7:13)
reltols = 1.0 ./ 10.0 .^ (4:10)

names2 = ["R2 PI .5" "R2 PI .7" "R2 Std .7" "R2 Pred .5" "R4 PI .8" "R4 PI .5"]

setups = [
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>5//10)
          Dict(:alg=>ROCK2(controller=:PI),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:Standard),:gamma=>7//10)
          Dict(:alg=>ROCK2(controller=:Predictive),:gamma=>5//10)
          Dict(:alg=>ROCK4(controller=:PI),:gamma=>8//10)
		  Dict(:alg=>ROCK4(controller=:PI),:gamma=>5//10)
		  ]
wp_11 = WorkPrecisionSet(prob,abstols,reltols,setups;
                      names=names2,save_everystep=false,appxsol=test_sol,maxiters=Int(1e5))
plot(wp_11,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_11.svg")


wp_12 = WorkPrecisionSet(prob,abstols,reltols,setups;verbose=false,
                      names=names2,dense=false,appxsol=test_sol,maxiters=Int(1e5),error_estimate=:l2)
plot(wp_12,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_12.svg")

wp_13 = WorkPrecisionSet(prob,abstols,reltols,setups;
                      names=names2,appxsol=test_sol,maxiters=Int(1e5),error_estimate=:L2)
plot(wp_13,dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_13.svg")


plot(wp_11[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
plot!(wp_11[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
plot!(wp_11[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
plot!(wp_11[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_11_ROCK2.svg")

plot(wp_11[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
plot!(wp_11[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_11_ROCK4.svg")

plot(wp_11[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
plot!(wp_11[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_11")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_11_Overall.svg")


plot(wp_12[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
plot!(wp_12[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
plot!(wp_12[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
plot!(wp_12[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_12_ROCK2.svg")

plot(wp_12[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
plot!(wp_12[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_12_ROCK4.svg")

plot(wp_12[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
plot!(wp_12[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_12")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_12_Overall.svg")

plot(wp_13[1],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
plot!(wp_13[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
plot!(wp_13[3],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
plot!(wp_13[4],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_13_ROCK2.svg")

plot(wp_13[5],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
plot!(wp_13[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_13_ROCK4.svg")

plot(wp_13[2],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
plot!(wp_13[6],dpi=200,legendfontsize=4,legend=:topright,linewidth=1,title="wp_13")
savefig("../../../opensource/Julia/OptimizationStabilizedMethods/wp_13_Overall.svg")
