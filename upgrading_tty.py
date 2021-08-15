import pty

def main():
	pty.spawn("/bin/bash")

if __name__ == '__main__':
	main()
