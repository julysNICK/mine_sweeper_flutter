import 'package:flutter/material.dart';
import 'package:mine_sweeper/ui/theme/colors.dart';
import 'package:mine_sweeper/utils/game_helper.dart';

class MainScreenApp extends StatefulWidget {
  const MainScreenApp({super.key});

  @override
  State<MainScreenApp> createState() => _MainScreenAppState();
}

class _MainScreenAppState extends State<MainScreenApp> {
  MineSweeperGame game = MineSweeperGame();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text('MineSweeper'),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.flag,
                        color: AppColor.accentColor,
                        size: 34.0,
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                            color: AppColor.accentColor,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.timer,
                        color: AppColor.accentColor,
                        size: 30.0,
                      ),
                      Text(
                        '20:30',
                        style: TextStyle(
                            color: AppColor.accentColor,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
              width: double.infinity,
              height: 500.0,
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MineSweeperGame.row,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: MineSweeperGame.cellCount,
                itemBuilder: (BuildContext ctx, index) {
                  Color cellColor = game.gameMap[index].reveal
                      ? AppColor.clickedCard
                      : AppColor.secondaryColor;

                  Color letterColor = game.gameMap[index].reveal
                      ? game.gameMap[index].content == "X"
                          ? Colors.red
                          : Colors.black
                      : AppColor.accentColor;
                  return GestureDetector(
                    onTap: game.gameOver
                        ? null
                        : () {
                            print("Clicked on $index");
                            setState(() {
                              game.getClickedCell(game.gameMap[index]);
                            });
                          },
                    child: Container(
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            game.gameMap[index].reveal
                                ? "${game.gameMap[index].content}"
                                : "",
                            style: TextStyle(
                                color: letterColor,
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  );
                },
              ))
        ],
      ),
    );
  }
}
