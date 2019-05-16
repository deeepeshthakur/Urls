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


