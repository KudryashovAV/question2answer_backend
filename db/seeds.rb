class Generators
  def generate_entities
    puts "Generation of test data starts!"

    AdminUser.create({ email: "admin@admin.com", password: "123456"})
    User.create({ email: "admin@admin.com", password: "123456789", location: "en", name: "Mike Vazovski", country: "Mali", city: "Asdert", bio: "admin", creation_type: "text", published: true})
    User.create({ email: "Mike@Vazovski.com", password: "123456789123456", location: "en", name: "Mike Vazovski", country: "Mali", city: "Asdert", bio: "Я успешный бизнесмен, владелец крупной компании в сфере информационных технологий. Начал свою карьеру с небольшого стартапа, который вырос в успешный бизнес благодаря его предпринимательскому духу и стратегическому мышлению. Активно поддерживаю стартап-сообщество и инвестирует в молодые технологические компании.", creation_type: "test", published: true})
    User.create({ email: "Stive@Dou.com", password: "123456789123456", location: "en", name: "Stive Dou", country: "Mali", city: "Asdert", bio: "Я успешный бизнесмен, владелец крупной компании в сфере информационных технологий. Начал свою карьеру с небольшого стартапа, который вырос в успешный бизнес благодаря его предпринимательскому духу и стратегическому мышлению. Активно поддерживаю стартап-сообщество и инвестирует в молодые технологические компании.", creation_type: "test", published: true})
    User.create({ email: "John@Dou.com", password: "123456789123456", location: "en", name: "John Dou", country: "Russia", city: "Moscow", bio: "Я успешный бизнесмен, владелец крупной компании в сфере информационных технологий. Начал свою карьеру с небольшого стартапа, который вырос в успешный бизнес благодаря его предпринимательскому духу и стратегическому мышлению. Активно поддерживаю стартап-сообщество и инвестирует в молодые технологические компании.", creation_type: "test", published: true})
    User.create({ email: "Robert@Hollander.com", password: "123456789123456", location: "en", name: "Robert Hollander", country: "India", city: "Deli", bio: "Я успешный бизнесмен, владелец крупной компании в сфере информационных технологий. Начал свою карьеру с небольшого стартапа, который вырос в успешный бизнес благодаря его предпринимательскому духу и стратегическому мышлению. Активно поддерживаю стартап-сообщество и инвестирует в молодые технологические компании.", creation_type: "test", published: true})
    User.create({ email: "Alexander@Ivanov.com", password: "123456789123456", location: "ru", name: "Александр Иванов", country: "Россия", city: "Москва", bio: "Я успешный бизнесмен, владелец крупной компании в сфере информационных технологий. Начал свою карьеру с небольшого стартапа, который вырос в успешный бизнес благодаря его предпринимательскому духу и стратегическому мышлению. Активно поддерживаю стартап-сообщество и инвестирует в молодые технологические компании.", creation_type: "test", published: true})
    User.create({ email: "Emily@Johnson.com", password: "123456789123456", location: "ru", name: "Emily Johnson", country: "США", city: "Нью-Йорк", bio: "Я талантливый фронтенд-разработчик, работающий в одной из крупнейших технологических компаний Нью-Йорка. Обладаю глубокими знаниями HTML, CSS и JavaScript, и ее работы отличаются высоким качеством и интуитивно понятным пользовательским интерфейсом. Активно принимаю участие в митапах и конференциях, где делится своими знаниями с другими разработчиками.", creation_type: "test", published: true})
    User.create({ email: "Juan@Martinez.com", password: "123456789123456", location: "ru", name: "Juan Martinez", country: "Испания", city: "Мадрид", bio: "Я талантливый аналитик данных, работающий в крупной финансовой компании в Мадриде. Имею обширный опыт в сборе и анализе данных, разработке алгоритмов и создании прогностических моделей. Активно участвую в проектах, связанных с обработкой больших данных и машинным обучением, и его работа помогает компании принимать обоснованные решения на основе данных.", creation_type: "test", published: true})
    User.create({ email: "Sophia@Müller.com", password: "123456789123456", location: "ru", name: "Sophia Müller", country: "Германия", city: "Берлин", bio: "Я опытный UX-дизайнер со страстью к созданию удобных и интуитивно понятных пользовательских интерфейсов. Работаю в крупной IT-компании в Берлине и ответственна за разработку и оптимизацию пользовательских путей, прототипирование и тестирование дизайн-концепций. Активно изучаю последние тенденции в UX-дизайне и стремится создавать непревзойденные цифровые впечатления для пользователей.", creation_type: "test", published: true})
    User.create({ email: "Mohammed@Ali.com", password: "123456789123456", location: "ru", name: "Mohammed Ali", country: "Египет", city: "Каир", bio: "Я опытный разработчик программного обеспечения, специализирующийся на разработке мобильных приложений. Работаю в успешной стартап-компании в Каире, где его работы отличаются высокой производительностью и инновационными возможностями. Слежу за последними технологическими трендами и стремится изучать новые языки программирования и фреймворки для улучшения своих навыков.", creation_type: "test", published: true})
    User.create({ email: "Isabella@Sanchez.com", password: "123456789123456", location: "ru", name: "Isabella Sanchez", country: "Испания", city: "Барселона", bio: "Я талантливый графический дизайнер с острым визуальным восприятием. Работаю в рекламном агентстве в Барселоне, где создает креативные и привлекательные дизайн-концепции для различных клиентов. Изабелла владеет широким спектром инструментов и техник дизайна, и ее работы отличаются эстетическим вкусом и профессионализмом.", creation_type: "test", published: true})
    User.create({ email: "Rajesh@Patel.com", password: "123456789123456", location: "ru", name: "Rajesh Patel", country: "Индия", city: "Бангалор", bio: "Я опытный разработчик веб-приложений, специализирующийся на бэкэнд-разработке. Работаю в технологической компании в Бангалоре, где взаимодействует с фронтенд-разработчиками, чтобы создавать эффективные и безопасные веб-приложения. Раджеш обладает глубокими знаниями языков программирования, таких как Java и Python, и активно исследует новые технологии для улучшения своих навыков.", creation_type: "test", published: true})
    User.create({ email: "Mia@Chen.com", password: "123456789123456", location: "ru", name: "Mia Chen", country: "Китай", city: "Шанхай", bio: "Я талантливый UI-дизайнер, специализирующийся на создании креативных и эстетически привлекательных пользовательских интерфейсов. Она работает в крупной IT-компании в Шанхае, где ее работы отличаются инновационным подходом и вниманием к деталям. Миа владеет широким спектром инструментов и языков программирования, и ее дизайны эффективно взаимодействуют с пользователем.", creation_type: "test", published: true})
    User.create({ email: "Luca@Rossi.com", password: "123456789123456", location: "ru", name: "Luca Rossi", country: "Италия", city: "Милан", bio: "Я опытный full-stack разработчик, специализирующийся на разработке веб-приложений. Работаю в веб-студии в Милане, где создает инновационные и высокопроизводительные веб-приложения для клиентов. Лука имеет глубокие знания языков программирования, таких как JavaScript и PHP, и активно слежу за последними технологическими трендами для улучшения своих навыков.", creation_type: "test", published: true})
    User.create({ email: "Maria@Santos.com", password: "123456789123456", location: "ru", name: "Maria Santos", country: "Бразилия", city: "Сан-Паулу", bio: "Я талантливый тестировщик программного обеспечения с опытом работы в крупной IT-компании в Сан-Паулу. Отвечаю за обеспечение высокого качества программного обеспечения путем выполнения тестовых сценариев, обнаружения и регистрации ошибок и сотрудничества с разработчиками для их исправления.", creation_type: "test", published: true})
    User.create({ email: "Ahmed@Khan.com", password: "123456789123456", location: "ru", name: "Ahmed Khan", country: "Пакистан", city: "Карачи", bio: "Я талантливый инженер-электронщик, работающий в авиационной компании в Карачи. Специализируюсь на разработке и тестировании электронных систем и компонентов для самолетов. Ахмед имеет богатый опыт работы в авиационной отрасли и принимает участие в различных проектах, связанных с улучшением безопасности и эффективности полетов.", creation_type: "test", published: true})
    User.create({ email: "Sophie@Dupont.com", password: "123456789123456", location: "ru", name: "Sophie Dupont", country: "Франция", city: "Париж", bio: "Я талантливая модель, работающая в модельном агентстве в Париже. Принимаю участие в различных показах мод и фотосессиях для известных модных брендов. Софи известна своей элегантностью, грацией и профессионализмом, и она стремится стать одной из ведущих моделей в индустрии.", creation_type: "test", published: true})
    User.create({ email: "Hiroshi@Tanaka.com", password: "123456789123456", location: "ru", name: "Hiroshi Tanaka", country: "Япония", city: "Токио", bio: "Я опытный инженер-робототехник, работающий в исследовательском центре в Токио. Занимаюсь разработкой и программированием роботов для различных целей, включая помощь в медицинских операциях и автоматизацию производственных процессов. Хироси является ведущим экспертом в области робототехники и принимает участие в международных конференциях и семинарах.", creation_type: "test", published: true})
    User.create({ email: "Isabella@Costa.com", password: "123456789123456", location: "ru", name: "Isabella Costa", country: "Италия", city: "Рим", bio: "Я талантливый писатель, известный своими романами и статьями. Живу в Риме и наслаждается богатой историей и культурой своей страны, которые вдохновляют ее на создание увлекательных историй. Изабелла является бестселлером и получила множество литературных наград за свои произведения.", creation_type: "test", published: true})
    User.create({ email: "Muhammad@Ali.com", password: "123456789123456", location: "ru", name: "Muhammad Ali", country: "Пакистан", city: "Лахор", bio: "Я известный спортсмен, боксер, из Лахора. Завоевал множество титулов и медалей в различных боксерских соревнованиях. Мухаммад является иконой бокса и вдохновляет молодое поколение своей упорной работой, дисциплиной и настойчивостью.", creation_type: "test", published: true})
    User.create({ email: "Anna@Petrova.com", password: "123456789123456", location: "ru", name: "Anna Petrova", country: "Россия", city: "Санкт-Петербург", bio: "Я талантливый художник, живущий и работающий в Санкт-Петербурге. Она специализируется на живописи пейзажей и портретов. Анна известна своими яркими и красочными произведениями и принимает участие в выставках и арт-проектах. Ее работы отражают ее любовь к природе и ее умение захватить красоту окружающего мира на холсте.", creation_type: "test", published: true})
    User.create({ email: "Miguel@Hernandez.com", password: "123456789123456", location: "en", name: "Miguel Hernandez", country: "Mexico", city: "Mexico City", bio: "Miguel is a talented chef, known for his innovative culinary creations. He owns a popular restaurant in Mexico City, where he combines traditional Mexican flavors with modern techniques to create unique and delicious dishes. Miguel is passionate about showcasing the diverse and vibrant cuisine of Mexico to the world.", creation_type: "test", published: true})
    User.create({ email: "Emily@Johnson.com", password: "123456789123456", location: "en", name: "Emily Johnson", country: "United States", city: "New York City", bio: "Emily is a successful businesswoman working in the finance industry in New York City. She holds a high-ranking position in a prominent investment firm and is known for her sharp intellect and strategic thinking. Emily is dedicated to her career and strives to break glass ceilings in the male-dominated corporate world.", creation_type: "test", published: true})
    User.create({ email: "Luiz@Silva.com", password: "123456789123456", location: "en", name: "Luiz Silva", country: "Brazil", city: "Rio de Janeiro", bio: "Luiz is a professional soccer player, representing Brazil on the international stage. He is a key player for his club team and has won numerous accolades for his exceptional skills and goal-scoring abilities. Luiz is adored by fans for his charismatic personality and his commitment to giving back to the community through various charitable initiatives.", creation_type: "test", published: true})
    User.create({ email: "Sofia@Gonzalez.com", password: "123456789123456", location: "en", name: "Sofia Gonzalez", country: "Spain", city: "Barcelona", bio: "Sofia is a talented flamenco dancer, captivating audiences with her grace and passion. She has trained extensively in the art of flamenco and performs regularly at prestigious venues in Barcelona and around the world. Sofia's performances are known for their intensity and emotional depth, leaving spectators mesmerized.", creation_type: "test", published: true})
    User.create({ email: "Chen@Wei.com", password: "123456789123456", location: "en", name: "Chen Wei", country: "China", city: "Beijing", bio: "Chen Wei is a renowned scientist specializing in renewable energy technologies. He has made significant contributions to the development of solar power systems and has received international recognition for his groundbreaking research. Chen Wei is dedicated to finding sustainable solutions to address the world's energy needs and combat climate change.", creation_type: "test", published: true})
    User.create({ email: "Maria@Santos.com", password: "123456789123456", location: "en", name: "Maria Santos", country: "Brazil", city: "São Paulo", bio: "Maria is a talented fashion designer based in São Paulo. She is known for her unique and avant-garde designs that blend traditional Brazilian elements with modern aesthetics. Maria has showcased her collections at major fashion events and has gained recognition for her creativity and attention to detail in the world of fashion.", creation_type: "test", published: true})
    User.create({ email: "Alexander@Ivanov.com", password: "123456789123456", location: "en", name: "Alexander Ivanov", country: "Russia", city: "Moscow", bio: "Alexander is a highly skilled ballet dancer with the renowned Bolshoi Ballet in Moscow. He has trained extensively in classical ballet and has performed lead roles in numerous productions, captivating audiences with his grace and precision. Alexander's dedication to his craft and his ability to convey emotions through his dance have made him a celebrated figure in the ballet world.", creation_type: "test", published: true})
    User.create({ email: "Leila@Ahmed.com", password: "123456789123456", location: "en", name: "Leila Ahmed", country: "Egypt", city: "Cairo", bio: "Leila is a respected archaeologist and historian specializing in ancient Egyptian civilizations. She has been involved in excavations and research projects across Egypt, uncovering valuable artifacts and shedding light on the rich history of the region. Leila's expertise and passion for preserving Egypt's cultural heritage have made her a prominent figure in the field of archaeology.", creation_type: "test", published: true})
    User.create({ email: "Diego@Fernandez.com", password: "123456789123456", location: "en", name: "Diego Fernandez", country: "Argentina", city: "Buenos Aires", bio: "Diego is a talented tango dancer and choreographer, known for his captivating performances that embody the spirit and passion of Argentine tango. He has traveled the world, teaching workshops and performing at renowned tango festivals. Diego's precision, musicality, and ability to connect with his dance partners have earned him recognition as one of the leading figures in the world of tango.", creation_type: "test", published: true})
    User.create({ email: "Aisha@Khan.com", password: "123456789123456", location: "en", name: "Aisha Khan", country: "United Arab Emirates", city: "Dubai", bio: "Aisha is a successful entrepreneur and businesswoman, running her own tech startup in Dubai. She is a trailblazer in the male-dominated tech industry and has been recognized for her innovative ideas and business acumen. Aisha is passionate about empowering women in the field of technology and serves as a mentor to aspiring entrepreneurs.", creation_type: "test", published: true})
    User.create({ email: "Juan@Lopez.com", password: "123456789123456", location: "en", name: "Juan Lopez", country: "Spain", city: "Madrid", bio: "Juan is a talented flamenco guitarist, renowned for his passionate and emotive performances. He has mastered the intricate techniques of flamenco guitar and has collaborated with various flamenco artists and dancers. Juan's music reflects the rich cultural heritage of Spain, and he is known for his ability to transport listeners to the heart of Andalusia through his music.", creation_type: "test", published: true})
    User.create({ email: "Meera@Patel.com", password: "123456789123456", location: "en", name: "Meera Patel", country: "India", city: "Mumbai", bio: "Meera is a successful Bollywood actress, known for her versatility and captivating performances on the big screen. She has starred in several critically acclaimed films and has won numerous awards for her acting prowess. Meera is admired for her charisma, talent, and dedication to her craft, and she is considered one of the leading actresses in the Indian film industry.", creation_type: "test", published: true})
    User.create({ email: "Luca@Ferrari.com", password: "123456789123456", location: "en", name: "Luca Ferrari", country: "Italy", city: "Florence", bio: "Luca is a renowned fashion designer based in Florence, Italy. He is known for his elegant and timeless creations that showcase the craftsmanship and sophistication of Italian fashion. Luca has dressed celebrities and royalty, and his designs have graced runways around the world. He is revered for his attention to detail and his ability to create garments that exude both luxury and wearability.", creation_type: "test", published: true})
    User.create({ email: "Nala@Mbeki.com", password: "123456789123456", location: "en", name: "Nala Mbeki", country: "South Africa", city: "Johannesburg", bio: "Nala is a dedicated environmental activist and conservationist, working tirelessly to protect endangered wildlife and preserve natural habitats in South Africa. She has founded several initiatives and organizations aimed at raising awareness about conservation and implementing sustainable practices. Nala's passion for the environment and her commitment to making a positive impact have earned her recognition and respect in the field.", creation_type: "test", published: true})
    User.create({ email: "Hiroshi@Nakamura.com", password: "123456789123456", location: "en", name: "Hiroshi Nakamura", country: "Japan", city: "Osaka", bio: "Hiroshi is a celebrated sushi chef, renowned for his mastery of the art of sushi-making. He owns a Michelin-starred sushi restaurant in Osaka, where he meticulously selects and prepares the freshest ingredients to create extraordinary culinary experiences. Hiroshi's dedication to quality and his ability to blend traditional techniques with innovative flavors have made him a sought-after figure in the world of sushi.", creation_type: "test", published: true})
    User.create({ email: "Isabella@Martinez.com", password: "123456789123456", location: "en", name: "Isabella Martinez", country: "Mexico", city: "Guadalajara", bio: "Isabella is a talented mariachi singer, known for her powerful and soulful voice. She has performed at various festivals and events, representing the rich musical heritage of Mexico. Isabella's performances are filled with passion and emotion, and she is celebrated for her ability to connect with audiences through her music.", creation_type: "test", published: true})
    User.create({ email: "Henrik@Andersen.com", password: "123456789123456", location: "en", name: "Henrik Andersen", country: "Denmark", city: "Copenhagen", bio: "Henrik is a renowned chef specializing in Nordic cuisine. He owns a highly acclaimed restaurant in Copenhagen, where he showcases the unique flavors and ingredients of the region. Henrik is known for his commitment to sustainable and locally sourced produce, and his dishes often reflect the simplicity and elegance that define Nordic gastronomy.", creation_type: "test", published: true})
    User.create({ email: "Aisha@Rahman.com", password: "123456789123456", location: "en", name: "Aisha Rahman", country: "Pakistan", city: "Lahore", bio: "Aisha is a prominent human rights activist, working to promote equality and social justice in Pakistan. She has been involved in various advocacy campaigns and has fought for the rights of marginalized communities. Aisha's determination and courage have made her a leading voice for change in her country.", creation_type: "test", published: true})
    User.create({ email: "Javier@Morales.com", password: "123456789123456", location: "en", name: "Javier Morales", country: "Spain", city: "Barcelona", bio: "Javier is a professional football player, playing as a midfielder for a top La Liga club. He is known for his exceptional technical skills, vision, and leadership on the field. Javier has won numerous titles and has represented his national team in international competitions. He is admired for his sportsmanship and his ability to inspire his teammates.", creation_type: "test", published: true})
    User.create({ email: "Mei@Ling.com", password: "123456789123456", location: "en", name: "Mei Ling", country: "China", city: "Shanghai", bio: "Mei Ling is a successful entrepreneur and founder of a tech startup in Shanghai. She is known for her groundbreaking innovations in the field of artificial intelligence and has received recognition for her contributions to advancing technology. Mei Ling's drive and determination have made her a role model for aspiring entrepreneurs, particularly women in the tech industry.", creation_type: "test", published: true})
    User.create({ email: "Gabriel@Silva.com", password: "123456789123456", location: "en", name: "Gabriel Silva", country: "Brazil", city: "Rio de Janeiro", bio: "Gabriel is a talented street artist known for his vibrant and eye-catching murals. His art often reflects the cultural diversity and social issues of Brazil. Gabriel's work can be seen across the streets of Rio de Janeiro, and he has gained recognition for his ability to use art as a form of expression and activism.", creation_type: "test", published: true})
    User.create({ email: "Olivia@Johnson.com", password: "123456789123456", location: "en", name: "Olivia Johnson", country: "United States", city: "Los Angeles", bio: "Olivia is a successful Hollywood actress, known for her versatility and captivating performances on the big screen. She has starred in a wide range of films, earning critical acclaim and numerous awards for her talent. Olivia is admired for her commitment to her craft and her ability to bring complex characters to life.", creation_type: "test", published: true})
    User.create({ email: "Gabriel@Silva.com", password: "123456789123456", location: "en", name: "Gabriel Silva", country: "Brazil", city: "Rio de Janeiro", bio: "Gabriel is a talented street artist known for his vibrant and eye-catching murals. His art often reflects the cultural diversity and social issues of Brazil. Gabriel's work can be seen across the streets of Rio de Janeiro, and he has gained recognition for his ability to use art as a form of expression and activism.", creation_type: "test", published: true})
    User.create({ email: "Haruki@Nakamura.com", password: "123456789123456", location: "en", name: "Haruki Nakamura", country: "Japan", city: "Kyoto", bio: "Haruki is a renowned master of origami, the art of paper folding. His creations range from small intricate designs to large-scale installations. Haruki's origami works have been exhibited in galleries around the world, and he is admired for his precision and ability to transform a simple sheet of paper into breathtaking art.", creation_type: "test", published: true})
    User.create({ email: "Fatima@Ahmed.com", password: "123456789123456", location: "en", name: "Fatima Ahmed", country: "Egypt", city: "Alexandria", bio: "Fatima is a highly respected archaeologist specializing in ancient Egyptian history and artifacts. She has been involved in numerous excavations and research projects, unearthing valuable insights into the ancient civilization. Fatima's expertise and dedication to preserving Egypt's cultural heritage have made her a prominent figure in the field of archaeology.", creation_type: "test", published: true})
    User.create({ email: "Carlos@Morales.com", password: "123456789123456", location: "en", name: "Carlos Morales", country: "Colombia", city: "Bogotá", bio: "Carlos is an accomplished salsa dancer and instructor. He has mastered the intricate footwork and rhythmic movements of salsa and has won multiple championships in national and international competitions. Carlos is known for his charisma and passion for sharing the joy of salsa dancing with others through his classes and performances.", creation_type: "test", published: true})
    User.create({ email: "Isabella@Rossi.com", password: "123456789123456", location: "en", name: "Isabella Rossi", country: "Italy", city: "Rome", bio: "Isabella is a renowned opera singer, captivating audiences with her powerful and melodious voice. She has performed leading roles in operas at prestigious venues worldwide, showcasing her vocal range and emotional depth. Isabella's performances are marked by her ability to convey the nuances of the music and transport listeners to another world.", creation_type: "test", published: true})
    User.create({ email: "Khaled@Al.com", password: "123456789123456", location: "en", name: "Khaled Al-Farsi", country: "Saudi Arabia", city: "Riyadh", bio: "Khaled is an influential entrepreneur and philanthropist, known for his successful business ventures and his commitment to social causes. He has founded various charitable organizations that focus on education, healthcare, and empowering marginalized communities. Khaled's innovative thinking and dedication to making a positive impact have earned him admiration and respect.", creation_type: "test", published: true})
    User.create({ email: "Emma@Dubois.com", password: "123456789123456", location: "en", name: "Emma Dubois", country: "France", city: "Paris", bio: "Emma is a talented fashion designer, renowned for her elegant and sophisticated designs. She has her own fashion label in Paris, where she creates haute couture and ready-to-wear collections. Emma's creations are characterized by their attention to detail, impeccable craftsmanship, and timeless appeal, making her a sought-after name in the fashion industry.", creation_type: "test", published: true})
    User.create({ email: "Hiroshi@Tanaka.com", password: "123456789123456", location: "en", name: "Hiroshi Tanaka", country: "Japan", city: "Tokyo", bio: "Hiroshi is a master sushi chef, running a renowned sushi restaurant in Tokyo. He has dedicated his life to perfecting the art of sushi-making, and his omakase (chef's choice) menus are highly sought after by sushi enthusiasts. Hiroshi's expertise lies in sourcing the finest, freshest ingredients and skillfully preparing them to create an unforgettable dining experience.", creation_type: "test", published: true})
    User.create({ email: "Sofia@Garcia.com", password: "123456789123456", location: "en", name: "Sofia Garcia", country: "Spain", city: "Barcelona", bio: "Sofia is a talented abstract painter known for her vibrant and expressive artworks. Her paintings often evoke emotions and invite viewers to interpret the imagery in their own unique way. Sofia's works have been exhibited in galleries and art fairs, and she is celebrated for her ability to create visually captivating pieces that resonate with audiences.", creation_type: "test", published: true})
    User.create({ email: "Ahmed@Khan.com", password: "123456789123456", location: "en", name: "Ahmed Khan", country: "Pakistan", city: "Islamabad", bio: "Ahmed is a renowned poet and writer, known for his profound and thought-provoking literary works. He has published several collections of poetry and novels that explore themes of love, identity, and social issues. Ahmed's writing has garnered critical acclaim and has touched the hearts of readers, making him a prominent figure in the literary world.", creation_type: "test", published: true})
    User.create({ email: "Maya@Patel.com", password: "123456789123456", location: "en", name: "Maya Patel", country: "India", city: "Jaipur", bio: "Maya is a skilled jewelry designer known for her intricate and exquisite creations. She draws inspiration from the rich cultural heritage of India, incorporating traditional motifs and techniques in her designs. Maya's jewelry has been worn by celebrities and showcased in fashion shows, and she is admired for her ability to create wearable pieces of art.", creation_type: "test", published: true})
    User.create({ email: "Santiago@Morales.com", password: "123456789123456", location: "en", name: "Santiago Morales", country: "Mexico", city: "Mexico City", bio: "Santiago is a talented filmmaker and director, known for his visually stunning and thought-provoking films. He has received critical acclaim for his unique storytelling and his ability to tackle complex social issues through his work. Santiago's films have been screened at international film festivals and have earned him numerous awards and recognition.", creation_type: "test", published: true})
    User.create({ email: "Li@Wei.com", password: "123456789123456", location: "en", name: "Li Wei", country: "China", city: "Beijing", bio: "Li Wei is a world-renowned acrobat and contortionist, known for his extraordinary flexibility and balance. He has performed jaw-dropping acts that push the limits of the human body, captivating audiences with his seemingly impossible feats. Li Wei's performances blend strength, grace, and artistry, making him an icon in the world of circus and acrobatics.", creation_type: "test", published: true})

    142.times do
      Tag.create(name: Faker::ProgrammingLanguage.name)
    end

    tag_ids = Tag.all.pluck(:id)
    user_ids = User.all.pluck(:id)

    100.times do |number|
      ru_title = "РУССКИЙ #{Faker::Lorem.question(word_count: (4...15).to_a.sample)}"
      ru_location = "RU"
      en_title = Faker::Lorem.question(word_count: (4...15).to_a.sample)
      en_location = "EN"

      generate_relations(ru_title, ru_location, user_ids, tag_ids, number)
      generate_relations(en_title, en_location, user_ids, tag_ids, number)
    end

    puts "Generation of test data finish."
  end

  def generate_users_document
    File.new("users.txt", "w")

    content_array = []
    users = User.all

    users.each do |user|
      content_array << "email:#{user.email}!@#password:#{user.password}!@#location:#{user.location}!@#name:#{user.name}!@#country:#{user.country}!@#city:#{user.city}!@#bio:#{user.bio}"
    end

    content = content_array.join("\n ")

    File.open("users.txt", "w") do |file|
      file.write(content)
    end
  end

  def generate_questions_document
    File.new("questions.txt", "w")
    content_array = []
    questions = Question.all

    questions.each do |question|
      question_comments = question.comments
      question_answers = question.answers

      question_substring = "-{Question}-title:#{question.title}!@#content:#{question.content}!@#location:#{question.location}"
      question_comments_substring = ""
      question_comments.each { |comment| question_comments_substring << "-{QComment}-content:#{comment.content}"}

      answers_substring = ""
      question_answers.each do |answer|
        answer_comments = answer.comments
        answer_comments_substring = ""
        answer_comments.each { |comment| answer_comments_substring << "-{AComment}-content:#{comment.content}"}
        answer_substring = "-{Answer}-content:#{question.content}"
        answers_substring << answer_substring + answer_comments_substring
      end

      tags_substring = "-{Tags}-tag_names:#{question.tags.pluck(:name).join("!@#")}"

      content_array << question_substring + question_comments_substring + answers_substring + tags_substring
    end

    content = content_array.join("\n ")

    File.open("questions.txt", "w") do |file|
      file.write(content)
    end
  end

  private

  def generate_relations(title, location, user_ids, tag_ids, question_count)
    question_user_id = user_ids.sample

    question = Question.create(
      title: title,
      content: Faker::Lorem.paragraph(sentence_count: (4...30).to_a.sample),
      user_id: question_user_id,
      slug: title.gsub(/[^a-zа-яёË]/i, "-")
                 .gsub(/-+/, "-")
                 .gsub(/\W$/, "")
                 .downcase,
      published: true,
      location: location,
      creation_type: "test"
    )

    user = User.find(question_user_id)
    user.update_column(:questions_count, user.questions_count + 1)

    answer_count = (1..10).to_a.sample
    answered_user_ids = []
    last_user_answered_id = 0

    answer_count.times do
      current_answered_user_id = (user_ids - [question_user_id] - answered_user_ids).sample
      answered_user_ids << current_answered_user_id
      last_user_answered_id = current_answered_user_id

      answer = Answer.create(
        question: question,
        content: Faker::Lorem.paragraph(sentence_count: (4...30).to_a.sample),
        user_id: current_answered_user_id,
        published: true,
        creation_type: "test"
      )

      user = User.find(current_answered_user_id)
      user.update_column(:answers_count, user.answers_count + 1)

      comment_count = (1..5).to_a.sample
      commented_user_ids = []
      last_user_answer_commented_id = 0

      comment_count.times do
        current_commented_user_id = (user_ids - commented_user_ids).sample
        commented_user_ids << current_commented_user_id
        last_user_answer_commented_id = current_commented_user_id

        Comment.create(
          commented_to: answer,
          content: Faker::Lorem.paragraph(sentence_count: (4...30).to_a.sample),
          user_id: current_commented_user_id,
          published: true,
          creation_type: "test"
        )

        user = User.find(current_commented_user_id)
        user.update_column(:comments_count, user.comments_count + 1)
      end

      answer.update_columns(comments_count: comment_count,
                            last_user_commented_id: last_user_answer_commented_id,
                            last_user_commented_type: "test")

    end

    question_comments_count = (1..5).to_a.sample
    question_commented_user_ids = []
    last_user_commented_id = 0

    question_comments_count.times do
      current_commented_user_id = (user_ids - [question_user_id] - question_commented_user_ids).sample
      question_commented_user_ids << current_commented_user_id
      last_user_commented_id = current_commented_user_id

      Comment.create(
        commented_to: question,
        content: Faker::Lorem.paragraph(sentence_count: (4...30).to_a.sample),
        user_id: current_commented_user_id,
        published: true,
        creation_type: "test"
      )

      user = User.find(current_commented_user_id)
      user.update_column(:comments_count, user.comments_count + 1)
    end

    tag_ids.shuffle.first((1..5).to_a.sample).each do |tag_id|
      QuestionTag.create(
        tag_id: tag_id,
        question: question
      )
    end

    question.update_columns(answers_count: answer_count,
                            comments_count: question_comments_count,
                            last_user_commented_id: last_user_commented_id,
                            last_user_answered_id: last_user_answered_id,
                            last_user_commented_type: "test",
                            last_user_answered_type: "test")

    question_count += 1

    puts "#{question_count} from 100 were created for #{location} location"
  end
end

Generators.new.generate_entities
Generators.new.generate_users_document
Generators.new.generate_questions_document