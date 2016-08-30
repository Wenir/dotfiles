import sys
import os


def main(max_x, max_y, x, y, direction):
    if direction == "Next":
        if max_x > x:
            os.popen('FvwmCommand "GotoPage 1p 0p"')
            return

        if max_y > y:
            os.popen('FvwmCommand "GotoPage 0 1p"')
            return

        os.popen('FvwmCommand "GotoPage 0 0"')

    else:
        if x > 0:
            os.popen('FvwmCommand "GotoPage -1p 0p"')
            return

        if y > 0:
            os.popen('FvwmCommand "GotoPage -1 -1p"')
            return

        os.popen('FvwmCommand "GotoPage -1 -1"')


if __name__ == '__main__':
    main(int(sys.argv[1]) - 1, int(sys.argv[2]) - 1, int(sys.argv[3]), int(sys.argv[4]), sys.argv[5])


