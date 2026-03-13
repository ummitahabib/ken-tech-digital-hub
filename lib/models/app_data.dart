import 'package:flutter/material.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class Service {
  final String id;
  final IconData icon;        // ← IconData, not String
  final String title;
  final String description;
  final List<String> features;
  final String tag;

  const Service({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.tag,
  });
}

class TeamMember {
  final String name;
  final String role;
  final String bio;
  final String imageUrl;
  final String linkedin;
  final String instagram;

  const TeamMember({
    required this.name,
    required this.role,
    required this.bio,
    required this.imageUrl,
    this.linkedin = '',
    this.instagram = '',
  });
}

class Project {
  final String title;
  final String client;
  final String category;
  final String description;
  final String imageUrl;
  final String result;

  const Project({
    required this.title,
    required this.client,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.result,
  });
}

class Testimonial {
  final String name;
  final String role;
  final String company;
  final String content;
  final String imageUrl;
  final double rating;

  const Testimonial({
    required this.name,
    required this.role,
    required this.company,
    required this.content,
    required this.imageUrl,
    required this.rating,
  });
}

class FaqItem {
  final String question;
  final String answer;
  const FaqItem({required this.question, required this.answer});
}

class BlogPost {
  final String title;
  final String category;
  final String excerpt;
  final String imageUrl;
  final String date;
  final int readMin;

  const BlogPost({
    required this.title,
    required this.category,
    required this.excerpt,
    required this.imageUrl,
    required this.date,
    required this.readMin,
  });
}

// ─── App Data ─────────────────────────────────────────────────────────────────

class AppData {
  static const List<Service> services = [
    Service(
      id: 'social-media',
      icon: Icons.share_rounded,
      title: 'Social Media Management',
      description: 'We craft, schedule, and manage content across all platforms — growing your audience and driving engagement that converts to real business results.',
      features: ['Content creation & scheduling', 'Community management', 'Analytics & reporting', 'Brand voice development'],
      tag: 'Most Popular',
    ),
    Service(
      id: 'digital-marketing',
      icon: Icons.rocket_launch_rounded,
      title: 'Digital Marketing Strategy',
      description: 'Full-funnel digital marketing strategies tailored to your business objectives. From awareness to conversion, we cover every touchpoint.',
      features: ['Market research & analysis', 'Campaign planning', 'Lead generation', 'ROI optimization'],
      tag: 'Strategy',
    ),
    Service(
      id: 'paid-ads',
      icon: Icons.ads_click_rounded,
      title: 'Paid Ads & PPC',
      description: 'Data-driven ad campaigns on Meta, Google, TikTok, and more. We maximize your ad spend to deliver qualified leads at the lowest cost per acquisition.',
      features: ['Facebook & Instagram Ads', 'Google Ads & PPC', 'TikTok advertising', 'Retargeting campaigns'],
      tag: 'High ROI',
    ),
    Service(
      id: 'content',
      icon: Icons.draw_rounded,
      title: 'Content Creation',
      description: 'Scroll-stopping visuals, compelling copy, and video content that tells your brand story and builds deep connections with your target audience.',
      features: ['Graphic design & branding', 'Video production', 'Copywriting & SEO', 'Reels & short-form video'],
      tag: 'Creative',
    ),
    Service(
      id: 'seo',
      icon: Icons.manage_search_rounded,
      title: 'SEO & Web Visibility',
      description: 'Get found online. We optimize your digital presence so you rank higher, attract organic traffic, and stay ahead of competitors in search results.',
      features: ['Technical SEO audit', 'Keyword research', 'On-page optimization', 'Link building'],
      tag: 'Organic Growth',
    ),
    Service(
      id: 'training',
      icon: Icons.school_rounded,
      title: 'Digital Skills Training',
      description: 'Hands-on, practical training programs for individuals and businesses looking to build in-house digital marketing capabilities and stay competitive.',
      features: ['Social media bootcamps', 'Digital marketing courses', 'One-on-one coaching', 'Team workshops'],
      tag: 'Training',
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Brand Relaunch Campaign',
      client: 'Lagos Fashion House',
      category: 'Social Media + Paid Ads',
      description: 'Complete social media overhaul and paid ad strategy for a premium fashion brand entering the Nigerian market.',
      imageUrl: 'https://images.unsplash.com/photo-1558655146-d09347e92766?w=500',
      result: '340% increase in followers',
    ),
    Project(
      title: 'Lead Generation Drive',
      client: 'Abuja Real Estate Firm',
      category: 'Digital Marketing',
      description: 'Targeted digital marketing campaign generating qualified leads for a high-end real estate developer in Abuja.',
      imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=500',
      result: '\u20a612M in qualified leads',
    ),
    Project(
      title: 'E-Commerce Growth',
      client: 'Naija Beauty Brand',
      category: 'SEO + Content',
      description: 'SEO and content strategy that doubled organic traffic and tripled online sales for a Nigerian beauty e-commerce brand.',
      imageUrl: 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=500',
      result: '3x online sales growth',
    ),
    Project(
      title: 'Meta Ads Optimization',
      client: 'EdTech Startup',
      category: 'Paid Ads',
      description: 'Restructured and optimized Meta ad campaigns for an education technology startup, slashing cost per lead by 60%.',
      imageUrl: 'https://images.unsplash.com/photo-1432888622747-4eb9a8efeb07?w=500',
      result: '60% lower cost per lead',
    ),
  ];

  static const List<TeamMember> team = [
    TeamMember(
      name: 'Kenneth Raphael',
      role: 'General Manager',
      bio: 'Digital strategist with 8+ years helping Nigerian businesses succeed in the digital landscape.',
      imageUrl: 'assets/images/gm.jpg',
      linkedin: 'https://ng.linkedin.com/company/kendigitaltechhub',
    ),
    TeamMember(
      name: 'Ahem Owudu',
      role: 'Manager of Ken Digital Tech Hub',
      bio: 'Social media expert with a track record of growing brand accounts from zero to viral.',
      imageUrl: 'assets/images/mn.jpg',
    ),
    TeamMember(
      name: 'Emeka Adeyemi',
      role: 'Assitant Manager',
      bio: 'Google & Meta certified expert who has managed over \u20a650M in ad spend across Nigeria.',
      imageUrl: 'assets/images/as.jpg',
    ),
   
  ];

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: 'Biodun Afolabi',
      role: 'CEO',
      company: 'Afolabi Homes & Properties',
      content: 'Ken Digital Tech Hub completely transformed our online presence. Within 3 months, our social media leads tripled and we closed our biggest deal ever directly from Instagram. Truly exceptional work.',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
      rating: 5,
    ),
    Testimonial(
      name: 'Ngozi Williams',
      role: 'Founder',
      company: 'Glow Beauty NG',
      content: 'Their content team is brilliant. They understood our brand voice instantly and created content that our audience absolutely loves. Sales through social are up 280% since we partnered with them.',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
      rating: 5,
    ),
    Testimonial(
      name: 'Tunde Salami',
      role: 'Marketing Director',
      company: 'TechBridge Nigeria',
      content: 'The paid ads strategy they built for us was a game changer. Our cost per lead dropped by 55% while lead quality went up significantly. I recommend Ken Digital to every business owner I know.',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      rating: 5,
    ),
  ];

  static const List<FaqItem> faqs = [
    FaqItem(
      question: 'What types of businesses do you work with?',
      answer: 'We work with businesses of all sizes across Nigeria — from solo entrepreneurs and SMEs to established corporations. Our expertise spans real estate, fashion, beauty, tech, education, hospitality, and more.',
    ),
    FaqItem(
      question: 'How soon can I expect to see results?',
      answer: 'Paid advertising campaigns can show results within the first 2 weeks. Social media growth and SEO are longer-term plays — most clients see meaningful traction within 60–90 days of consistent strategy execution.',
    ),
    FaqItem(
      question: 'Do you offer month-to-month contracts?',
      answer: 'Yes. We offer flexible monthly retainer agreements with no long-term lock-in. We believe in earning your business every month by delivering real results.',
    ),
    FaqItem(
      question: 'Can you manage multiple social media platforms at once?',
      answer: 'Absolutely. We manage Instagram, Facebook, TikTok, LinkedIn, X (Twitter), and YouTube. Most clients start with 2-3 platforms and scale up as they grow.',
    ),
    FaqItem(
      question: 'Do you offer digital marketing training?',
      answer: 'Yes! We run in-person and virtual training programs covering social media management, content creation, paid ads, and overall digital marketing strategy. These are great for entrepreneurs and corporate teams.',
    ),
    FaqItem(
      question: 'How do I get started with Ken Digital Tech Hub?',
      answer: 'Simply reach out via our contact form or WhatsApp. We will schedule a free discovery call to understand your business goals, then propose a tailored strategy that fits your budget and objectives.',
    ),
  ];

  // ── Stats now use IconData ────────────────────────────────────────────────
  static const List<Map<String, dynamic>> stats = [
    {'value': '200+',  'label': 'Clients Served',    'icon': Icons.handshake_rounded},
    {'value': '\u20a650M+', 'label': 'Ad Spend Managed',  'icon': Icons.trending_up_rounded},
    {'value': '8+',    'label': 'Years Experience',  'icon': Icons.workspace_premium_rounded},
    {'value': '98%',   'label': 'Client Retention',  'icon': Icons.verified_rounded},
  ];

  static const List<String> serviceCategories = [
    'All', 'Social Media', 'Paid Ads', 'Content', 'SEO', 'Strategy', 'Training',
  ];

  static const List<BlogPost> blogPosts = [
    BlogPost(
      title: 'How Nigerian SMEs Can Win on Social Media in 2025',
      category: 'Social Media',
      excerpt: 'The social media landscape has evolved. Here\'s what actually works for Nigerian businesses right now.',
      imageUrl: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=500',
      date: 'Mar 5, 2025',
      readMin: 6,
    ),
    BlogPost(
      title: 'Meta Ads vs. Google Ads: Which is Right for Your Business?',
      category: 'Paid Ads',
      excerpt: 'A practical breakdown to help Nigerian business owners choose the right platform for their ad budget.',
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=500',
      date: 'Feb 20, 2025',
      readMin: 8,
    ),
    BlogPost(
      title: '5 Content Mistakes Killing Your Brand Engagement',
      category: 'Content',
      excerpt: 'Are you making these common content errors? Find out what to fix to see immediate improvement.',
      imageUrl: 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=500',
      date: 'Feb 8, 2025',
      readMin: 5,
    ),
  ];

  static const List<Map<String, String>> partners = [
    {'name': 'Meta Business',     'logo': 'META'},
    {'name': 'Google Partner',    'logo': 'GOOGLE'},
    {'name': 'TikTok for Business','logo': 'TIKTOK'},
    {'name': 'LinkedIn Marketing','logo': 'LINKEDIN'},
    {'name': 'Hootsuite',         'logo': 'HOOTSUITE'},
    {'name': 'Canva for Teams',   'logo': 'CANVA'},
  ];
}