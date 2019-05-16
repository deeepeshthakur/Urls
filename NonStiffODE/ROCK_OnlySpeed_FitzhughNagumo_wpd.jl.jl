using OrdinaryDiffEq, ParameterizedFunctions, DiffEqDevTools

f = @ode_def FitzhughNagumo begin
  dv = v - v^3/3 -w + l
  dw = τinv*(v +  a - b*w)
end a b τinv l

p = [0.7,0.8,1/12.5,0.5]
prob = ODEProblem(f,[1.0;1.0],(0.0,10.0),p)

abstols = 1.0 ./ 10.0 .^ (6:13)
reltols = 1.0 ./ 10.0 .^ (3:10);

sol = solve(prob,Vern7(),abstol=1/10^14,reltol=1/10^14)
test_sol = TestSolution(sol)
using Plots; gr()


plot(sol)

Names = ["ROCK2 Predictive 10" "ROCK2 Predictive 2" "ROCK2 Standard 10" "ROCK2 Standard 2" "ROCK2 PI 10" "ROCK2 PI 2" "ROCK4 Predictive 10" "ROCK4 Predictive 2" "ROCK4 Standard 10" "ROCK4 Standard 2" "ROCK4 PI 10" "ROCK4 PI 2"]

setups = [
          Dict(:alg=>ROCK2(controller=:Predictive))
          Dict(:alg=>ROCK2(controller=:Predictive),:qmax=>2.0)
          Dict(:alg=>ROCK2(controller=:Standard))
          Dict(:alg=>ROCK2(controller=:Standard),:qmax=>2.0)
          Dict(:alg=>ROCK2(controller=:PI))
          Dict(:alg=>ROCK2(controller=:PI),:qmax=>2.0)
          Dict(:alg=>ROCK4(controller=:Predictive))
          Dict(:alg=>ROCK4(controller=:Predictive),:qmax=>2.0)
          Dict(:alg=>ROCK4(controller=:Standard))
          Dict(:alg=>ROCK4(controller=:Standard),:qmax=>2.0)
          Dict(:alg=>ROCK4(controller=:PI))
          Dict(:alg=>ROCK4(controller=:PI),:qmax=>2.0)
          ]
wp = WorkPrecisionSet(prob,abstols,reltols,setups;names=Names,appxsol=test_sol,save_everystep=false,numruns=2,maxiters=1e6)
plot(wp,dpi=200)
